#ifndef SOURCE_H
#define SOURCE_H

#include <mpi.h>

#include <awp/definitions.h>
#include <awp/pmcl3d_cons.h>
#include <buffers/buffer.h>
#include <test/test.h>
#include <awp/error.h>
#include <readers/input.h>
#include <grid/grid_3d.h>
#include <topography/grids.h>
#include <topography/metrics/metrics.h>
#include <mpi/io.h>
#include <interpolation/interpolation.cuh>
#include <topography/mapping.h>

// Offsets in grid spacings factor with respect to the previous grid
#define SOURCE_DM_OFFSET_X 0
#define SOURCE_DM_OFFSET_Y -1

typedef struct {
        int *indices;
        int *offsets;
        int *blocklen;
        size_t length;
        // parameter space coordinates
        int *global_indices[MAXGRIDS];
        // Adjusted coordinates for placing sources/receivers consistent with
        // DM with respect to grids that use a local coordinate system (internal
        // coordinate system)
        prec *x[MAXGRIDS];
        prec *y[MAXGRIDS];
        prec *z[MAXGRIDS];
        // User coordinates that are specified in the input file
        prec *xu[MAXGRIDS];
        prec *yu[MAXGRIDS];
        prec *zu[MAXGRIDS];
        int *type[MAXGRIDS];
        size_t lengths[MAXGRIDS];
        size_t num_elements;
        cu_interp_t interpolation[MAXGRIDS];
        mpi_io_idx_t io;
        buffer_t buffer;
        prec *host_buffer_extra;
        MPI_Comm comm;
        int use;
        char filename[STR_LEN*2];
        int ngrids;
        size_t steps;

} source_t;


// Source type determines how to partition velocity and stress input/output types across
// an MPI subdomain. 
enum source_type {MOMENT_TENSOR, FORCE, RECEIVER, SGT};

source_t source_init(const char *file_end, 
                     const enum grid_types grid_type,
                     const input_t *input,
                     const grids_t *grids, 
                     const struct mapping *map, 
                     const int ngrids,
                     const f_grid_t *f, 
                     const int rank,
                     const MPI_Comm comm,
                     const enum source_type st);

void source_finalize(source_t *src);

void source_find_grid_number(const input_t *input, const
                             grids_t *grids, int *grid_number, 
                             const int *indices,
                             const int length,
                             const int num_grids,
                             const int is_topo);
void source_init_common(source_t *src, const char *filename,
                        const enum grid_types grid_type, 
                        const input_t *input, 
                        const grids_t *grids, 
                        const struct mapping *map,
                        const int ngrids,
                        const f_grid_t *f,
                        const int rank, 
                        const MPI_Comm comm,
                        const enum source_type st);
MPI_Comm source_communicator(source_t *src, const int rank,
                             const MPI_Comm comm);
void source_read(source_t *src, size_t step);
void source_add_cartesian(prec *out, source_t *src, const size_t step,
                          const prec h, const prec dt, const int grid_num);

// zhat: indicates if the source should be applied on the cell-centered grid in
// the z-direction or not
void source_add_curvilinear(prec *out, source_t *src, const size_t step,
                            const prec h, const prec dt, const prec *f,
                            const int ny, const prec *dg, const int grid_num, const int zhat);

void source_add_force(prec *out, const prec *d1, source_t *src,
                      const size_t step, const prec h, const prec dt,
                      const prec quad_weight,
                      const prec *f, const int nx, const int ny, const int nz, 
                      const prec *dg,
                      const int grid_num, const int sourcetype, const int dir);

#endif

