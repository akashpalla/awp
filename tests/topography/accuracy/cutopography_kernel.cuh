#ifndef CUTOPOGRAPHY_KERNEL_H
#define CUTOPOGRAPHY_KERNEL_H
#include "definitions.h"
#include <math.h>

__global__ void dtopo_vel_110(
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *rho,
    const float *s11, const float *s12, const float *s13, const float *s22,
    const float *s23, const float *s33, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bi, const int bj,
    const int ei, const int ej);
__global__ void dtopo_vel_111(
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *rho,
    const float *s11, const float *s12, const float *s13, const float *s22,
    const float *s23, const float *s33, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bi, const int bj,
    const int ei, const int ej);
__global__ void dtopo_vel_112(
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *rho,
    const float *s11, const float *s12, const float *s13, const float *s22,
    const float *s23, const float *s33, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bi, const int bj,
    const int ei, const int ej);
__global__ void dtopo_buf_vel_110(
    float *buf_u1, float *buf_u2, float *buf_u3, const float *dcrjx,
    const float *dcrjy, const float *dcrjz, const float *f, const float *f1_1,
    const float *f1_2, const float *f1_c, const float *f2_1, const float *f2_2,
    const float *f2_c, const float *f_1, const float *f_2, const float *f_c,
    const float *g, const float *g3, const float *g3_c, const float *g_c,
    const float *rho, const float *s11, const float *s12, const float *s13,
    const float *s22, const float *s23, const float *s33, const float *u1,
    const float *u2, const float *u3, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bj, const int ej,
    const int rj0);
__global__ void dtopo_buf_vel_111(
    float *buf_u1, float *buf_u2, float *buf_u3, const float *dcrjx,
    const float *dcrjy, const float *dcrjz, const float *f, const float *f1_1,
    const float *f1_2, const float *f1_c, const float *f2_1, const float *f2_2,
    const float *f2_c, const float *f_1, const float *f_2, const float *f_c,
    const float *g, const float *g3, const float *g3_c, const float *g_c,
    const float *rho, const float *s11, const float *s12, const float *s13,
    const float *s22, const float *s23, const float *s33, const float *u1,
    const float *u2, const float *u3, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bj, const int ej,
    const int rj0);
__global__ void dtopo_buf_vel_112(
    float *buf_u1, float *buf_u2, float *buf_u3, const float *dcrjx,
    const float *dcrjy, const float *dcrjz, const float *f, const float *f1_1,
    const float *f1_2, const float *f1_c, const float *f2_1, const float *f2_2,
    const float *f2_c, const float *f_1, const float *f_2, const float *f_c,
    const float *g, const float *g3, const float *g3_c, const float *g_c,
    const float *rho, const float *s11, const float *s12, const float *s13,
    const float *s22, const float *s23, const float *s33, const float *u1,
    const float *u2, const float *u3, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bj, const int ej,
    const int rj0);
__global__ void dtopo_str_110(
    float *s11, float *s12, float *s13, float *s22, float *s23, float *s33,
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *lami,
    const float *mui, const float a, const float nu, const int nx, const int ny,
    const int nz, const int bi, const int bj, const int ei, const int ej);
__global__ void dtopo_str_111(
    float *s11, float *s12, float *s13, float *s22, float *s23, float *s33,
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *lami,
    const float *mui, const float a, const float nu, const int nx, const int ny,
    const int nz, const int bi, const int bj, const int ei, const int ej);
__global__ void dtopo_str_112(
    float *s11, float *s12, float *s13, float *s22, float *s23, float *s33,
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *lami,
    const float *mui, const float a, const float nu, const int nx, const int ny,
    const int nz, const int bi, const int bj, const int ei, const int ej);
__global__ void dtopo_init_material_111(float *lami, float *mui, float *rho,
                                        const int nx, const int ny,
                                        const int nz);
#endif