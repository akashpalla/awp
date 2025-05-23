#include <stdio.h>
#include <stdlib.h>

#include <awp/pmcl3d_cons.h>
#include <topography/grids.h>
#include <test/test.h>
#include <grid/grid_3d.h>
#include <grid/shift.h>

grids_t grids_init(const int nx, const int ny, const int nz, const int coord_x,
                   const int coord_y, const int coord_z,
                   const int topography, 
                   const prec gridspacing) 
{
        int3_t size = {.x = nx, .y = ny, .z = nz};
        int3_t coord = {.x = coord_x, .y = coord_y, .z = 0};

        int3_t bnd1 = {0, 0, 0};
        int3_t bnd2 = {0, 0, topography};

        grids_t grids;

        prec h = gridspacing;

        // velocity grids
        grids.x = grid_init(size, grid_x(), coord, bnd1, bnd2, 2 + ngsl, h);
        grids.y = grid_init(size, grid_y(), coord, bnd1, bnd2, 2 + ngsl, h);
        grids.z = grid_init(size, grid_z(), coord, bnd1, bnd2, 2 + ngsl, h);

        // stress grids
        grids.xx = grid_init(size, grid_xx(), coord, bnd1, bnd2, 2 + ngsl, h);
        grids.yy = grid_init(size, grid_yy(), coord, bnd1, bnd2, 2 + ngsl, h);
        grids.zz = grid_init(size, grid_zz(), coord, bnd1, bnd2, 2 + ngsl, h);
        grids.xy = grid_init(size, grid_xy(), coord, bnd1, bnd2, 2 + ngsl, h);
        grids.xz = grid_init(size, grid_xz(), coord, bnd1, bnd2, 2 + ngsl, h);
        grids.yz = grid_init(size, grid_yz(), coord, bnd1, bnd2, 2 + ngsl, h);

        // Material and topography grid
        grids.node = grid_init(size, grid_node(), coord, bnd1, bnd2, 2 + ngsl, h);

        return grids;
}

void grids_finalize(grids_t *grids)
{
}

void grid_data_init(grid_data_t *grid_data, const grid3_t grid, const int block_number)
{
        grid1_t xgrid = grid_grid1_x(grid);
        grid1_t ygrid = grid_grid1_y(grid);
        grid1_t zgrid = grid_grid1_z(grid);
        grid_data->x = malloc(sizeof grid_data->x * xgrid.size);
        grid_data->y = malloc(sizeof grid_data->y * ygrid.size);
        grid_data->z = malloc(sizeof grid_data->z * zgrid.size);
        grid_fill1(grid_data->x, xgrid, 1);
        grid_fill_y_dm(grid_data->y, ygrid, block_number);
        grid_fill1(grid_data->z, zgrid, 0);
}

void grid_data_free(grid_data_t *grid_data)
{
        free(grid_data->x);
        free(grid_data->y);
        free(grid_data->z);
}

grid3_t grids_select(const enum grid_types grid_type, const grids_t *grids)
{
        switch (grid_type) {
                case X:
                        return grids->x;
                        break;
                case Y:
                        return grids->y;
                        break;
                case Z:
                        return grids->z;
                        break;
                case SX:
                        return grids->x;
                        break;
                case SY:
                        return grids->y;
                        break;
                case SZ:
                        return grids->z;
                        break;
                case XX:
                        return grids->xx;
                        break;
                case YY:
                        return grids->yy;
                        break;
                case ZZ:
                        return grids->zz;
                        break;
                case XY:
                        return grids->xy;
                        break;
                case XZ:
                        return grids->xz;
                        break;
                case YZ:
                        return grids->yz;
                        break;
                case NODE:
                        return grids->node;
                        break;
                default:
                        fprintf(stderr, "Unknown grid type\n");
                        exit(1);
                        break;
                }

}

const char *grid_typename(const enum grid_types gt) {
        switch(gt) {
                case X:
                        return "X";
                case Y:
                        return "Y";
                case Z:
                        return "Z";
                case SX:
                        return "SX";
                case SY:
                        return "SY";
                case SZ:
                        return "SZ";
                case XX:
                        return "XX";
                case XY:
                        return "XY";
                case YY:
                        return "YY";
                case ZZ:
                        return "ZZ";
                case XZ:
                        return "XZ";
                case YZ:
                        return "YZ";
                case NODE:
                        return "NODE";
        }
        return "";
}

