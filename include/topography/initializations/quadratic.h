#pragma once
#ifndef TOPO_INIT_QUADRATIC_H
#define TOPO_INIT_QUADRATIC_H


#include <awp/definitions.h>

#ifdef __cplusplus
extern "C" {
#endif

void topo_d_quadratic_i(topo_t *T, prec *d_field);
void topo_d_quadratic_j(topo_t *T, prec *d_field);
void topo_d_quadratic_k(topo_t *T, prec *d_field);

#ifdef __cplusplus
}
#endif
#endif


