#ifndef _TOPOGRAPHY_MAPPING_H
#define _TOPOGRAPHY_MAPPING_H
#define OVERLAP 7.0
#define MAPPING_START_POINT 7
#define MAPPING_INVERSION_TOL 1e-2
#define MAPPING_MAX_ITER 1000

struct mapping {
    double dzb;
    double dzt;
    double h;
    double r[4];
    double z[4];
    double m[4];
};


double map_height(const int nz, const double dz);
struct mapping map_init(const double dzb, const double dzt, const double h);
int map_find_cell_r(const double r, const struct mapping *map);
int map_find_cell_z(const double z, const struct mapping *map);
double map_eval(const double r, const struct mapping *map);
double map_eval_derivative(const double r, const struct mapping *map);
double map_invert(const double z, const struct mapping *map, const double eps, const int maxiter);

// Error handling 
enum map_err_codes {MAP_SUCCESS, MAP_NON_MONOTONIC, MAP_OUTSIDE};

const char* map_error_string(const enum map_err_codes err_code);
enum map_err_codes map_get_last_error(void);

#endif
