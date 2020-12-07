#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <stdint.h>

#include <topography/sources/source.cuh>
#include <interpolation/interpolation.cuh>
#include <test/test.h>


// Enable or disable atomic operations. If the sources are overlapping, disabling atomics causes
// parallel synchronization issues. Only disable this macro if you know that the sources are
// non-overlapping.
#define USE_ATOMICS 1

void cusource_add_cartesian_H(const cu_interp_t *I, prec *out, const prec *in,
                              const prec h, const prec dt)
{
        dim3 block (INTERP_THREADS, 1, 1);
        dim3 grid((I->num_query + INTERP_THREADS - 1) / INTERP_THREADS,
                  1, 1);

        cusource_add_cartesian<<<grid, block>>>(
            out, in, I->d_lx, I->d_ly, I->d_lz, I->num_basis, I->d_ix, I->d_iy,
            I->d_iz, I->d_ridx, h, dt, I->num_query, I->grid);
        CUCHK(cudaGetLastError());
}

__global__ void cusource_add_cartesian(prec *out, const prec *in,
                                 const prec *lx, const prec *ly, const prec *lz,
                                 const int num_basis, const int *ix,
                                 const int *iy, const int *iz,
                                 const int *lidx,
                                 const prec h, const prec dt,
                                 const int num_query, const grid3_t grid)
{
        int q = threadIdx.x + blockDim.x * blockIdx.x;
        if (q >= num_query) {
                return;
        }

        prec dth = dt/(h * h * h);

        for (int i = 0; i < num_basis; ++i) {
        for (int j = 0; j < num_basis; ++j) {
        for (int k = 0; k < num_basis; ++k) {
                size_t pos = grid_index(grid, ix[q] + i, iy[q] + j, iz[q] + k);
                prec value = - dth * lx[q * num_basis + i] *
                            ly[q * num_basis + j] * lz[q * num_basis + k] *
                            in[lidx[q]];
#if USE_ATOMICS
                atomicAdd(&out[pos], value);
#else 
                out[pos] = value;
#endif


        }
        }
        }
}

void cusource_add_curvilinear_H(const cu_interp_t *I, prec *out, const prec *in,
                                const prec h, const prec dt, const prec *f,
                                const int ny, const prec *dg, const int zhat) 
{
        dim3 block (INTERP_THREADS, 1, 1);
        dim3 grid((I->num_query + INTERP_THREADS - 1) / INTERP_THREADS,
                  1, 1);

        cusource_add_curvilinear<<<grid, block>>>(
            out, in, I->d_lx, I->d_ly, I->d_lz, I->num_basis, I->d_ix, I->d_iy,
            I->d_iz, I->d_ridx, h, dt, I->num_query, I->grid, f, ny, dg, zhat);
        CUCHK(cudaGetLastError());
}

__global__ void cusource_add_curvilinear(prec *out, const prec *in,
                                 const prec *lx, const prec *ly, const prec *lz,
                                 const int num_basis, const int *ix,
                                 const int *iy, const int *iz,
                                 const int *lidx,
                                 const prec h, const prec dt,
                                 const int num_query, const grid3_t grid,
                                 const prec *f, const int ny, const prec *dg, const int zhat)
{
        int q = threadIdx.x + blockDim.x * blockIdx.x;
        if (q >= num_query) {
                return;
        }

#define _f(i, j)                                                             \
  f[(j) + align +                                                     \
      ((i) + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _dg(k) dg[(k) + align]

        prec dth = dt / (h * h * h);

        // Quadrature weights near the top boundary in the z-direction. First weight is on the
        // boundary
        // hweights: weights at the nodal grid points
        const prec hweights[4] = {0.34939236111111110494320541874913,
                                  1.24348958333333325931846502498956,
                                  0.88151041666666662965923251249478,
                                  1.02560763888888883954564334999304};
        // hhatweights: weights at the cell-centered grid points
        const prec hhatweights[4] = {0.12638888888888888395456433499930,
                                     0.84635416666666662965923251249478,
                                     1.03298611111111116045435665000696,
                                     0.99427083333333332593184650249896};

        int nz = grid.size.z;
        // Print statements used for debugging
        //printf("nz = %d %d offset = %d | ", grid.size.z, iz[q], nz - iz[q] - 1);
        //for (int k = 0; k < num_basis; ++k) 
        //        printf("%d ", iz[q] + k);
        //printf("| ");
        //for (int k = 0; k < num_basis; ++k) 
        //        printf("%f ", lz[q * num_basis + k]);
        //printf("| ");
        //if (zhat == 0) {
        //for (int k = 0; k < num_basis; ++k) 
        //        printf("%d ", nz - (iz[q] + 2 + k));
        //} else {
        //for (int k = 0; k < num_basis; ++k) 
        //        printf("%d ", nz - (iz[q] + 1 + k));
        //}
        //printf("\n");
        for (int i = 0; i < num_basis; ++i) {
        for (int j = 0; j < num_basis; ++j) {
        for (int k = 0; k < num_basis; ++k) {
               prec Ji =
                   1.0 / (_f(i + ix[q], j + iy[q]) *
                          _dg(iz[q] + k));
                size_t pos = grid_index(grid, ix[q] + i, iy[q] + j, iz[q] + k);
                prec w = 1.0f;
                int offset_z = nz - (iz[q] + k + 2);
                int offset_zhat = nz - (iz[q] + k + 1);
                if (zhat == 0 &&  offset_z  < 4 && offset_z >= 0)
                        w = hweights[offset_z];
                if (zhat == 1 &&  offset_zhat < 4 && offset_zhat >= 0)
                        w = hhatweights[offset_zhat];
                prec value = - dth * lx[q * num_basis + i] *
                            ly[q * num_basis + j] * lz[q * num_basis + k] *
                            in[lidx[q]] * Ji * w;
#if USE_ATOMICS
                atomicAdd(&out[pos], value);
#else 
                out[pos] = value;
#endif
        }
        }
        }
}

void cusource_add_force_H(const cu_interp_t *I, prec *out, const prec *in,
                          const prec *d1, const prec h, const prec dt,
                          const prec quad_weight,
                          const prec *f, const int nx, const int ny,
                          const int nz, const prec *dg) 
{
        dim3 block (INTERP_THREADS, 1, 1);
        dim3 grid((I->num_query + INTERP_THREADS - 1) / INTERP_THREADS,
                  1, 1);

        cusource_add_force<<<grid, block>>>(
            out, in, d1, I->d_lx, I->d_ly, I->d_lz, I->num_basis, I->d_ix,
            I->d_iy, I->d_iz, I->d_ridx, h, dt, quad_weight, I->num_query,
            I->grid, f, nx, ny, nz, dg);
        CUCHK(cudaGetLastError());
}

__global__ void cusource_add_force(prec *out, const prec *in, const prec *d1,
                                   const prec *lx, const prec *ly,
                                   const prec *lz, const int num_basis,
                                   const int *ix, const int *iy, const int *iz,
                                   const int *lidx, const prec h, const prec dt,
                                   const prec quad_weight,
                                   const int num_query, const grid3_t grid,
                                   const prec *f, const int nx, const int ny,
                                   const int nz, const prec *dg) 
{
        int q = threadIdx.x + blockDim.x * blockIdx.x;
        if (q >= num_query) {
                return;
        }

#define _f(i, j)                                                             \
  f[(j) + align +                                                     \
      ((i) + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _dg(k) dg[(k) + align]

#define _rho(i, j, k)                                                  \
        d1[(k) + align +                                               \
           (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
           (2 * align + nz) * ((j) + ngsl + 2)]

        prec dth = dt / (h * h * h);

        for (int i = 0; i < num_basis; ++i) {
        for (int j = 0; j < num_basis; ++j) {
        for (int k = 0; k < num_basis; ++k) {
                prec Ji =
                    - quad_weight / (_f(i + ix[q], j + iy[q]) * _dg(iz[q] + k) *
                                   _rho(i + ix[q], j + iy[q], iz[q] + k));
                size_t pos = grid_index(grid, ix[q] + i, iy[q] + j, iz[q] + k);
                prec value = -dth * lx[q * num_basis + i] *
                            ly[q * num_basis + j] * lz[q * num_basis + k] * in[lidx[q]] * Ji;
#if USE_ATOMICS
                atomicAdd(&out[pos], value);
#else 
                out[pos] = value;
#endif
        }
        }
        }
}

