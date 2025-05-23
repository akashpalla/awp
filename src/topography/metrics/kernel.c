#include <topography/metrics/kernel.h>
#
// This parameter pads the compute region. Its needed for the computation of
// derivative and interpolation stencils. Do not change its value.
#define padding 8

void metrics_f_interp_1_111(float *df1, const float *f, const int nx, const int ny, const int nz)
{
     const float phy[4] = {-0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000};
     for (int k = 0; k < 1; ++k) {
         for (int j = 0; j < 2*padding + ny - 4; ++j) {
             for (int i = 0; i < 2*padding + nx - 4; ++i) {
                  #define _f(i,j) f[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  #define _df1(i,j) df1[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  _df1(-padding + i + 2,-padding + j + 2) = phy[0]*_f(-padding + i + 2,-padding + j) + phy[1]*_f(-padding + i + 2,-padding + j + 1) + phy[2]*_f(-padding + i + 2,-padding + j + 2) + phy[3]*_f(-padding + i + 2,-padding + j + 3);
                  #undef _f
                  #undef _df1
                  
             }
         }
     }
     
}

void metrics_f_interp_2_111(float *df1, const float *f, const int nx, const int ny, const int nz)
{
     const float px[4] = {-0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000};
     for (int k = 0; k < 1; ++k) {
         for (int j = 0; j < 2*padding + ny - 4; ++j) {
             for (int i = 0; i < 2*padding + nx - 4; ++i) {
                  #define _f(i,j) f[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  #define _df1(i,j) df1[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  _df1(-padding + i + 2,-padding + j + 2) = px[0]*_f(-padding + i + 1,-padding + j + 2) + px[1]*_f(-padding + i + 2,-padding + j + 2) + px[2]*_f(-padding + i + 3,-padding + j + 2) + px[3]*_f(-padding + i + 4,-padding + j + 2);
                  #undef _f
                  #undef _df1
                  
             }
         }
     }
     
}

void metrics_f_interp_c_111(float *df1, const float *f, const int nx, const int ny, const int nz)
{
     const float phy[4] = {-0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000};
     const float px[4] = {-0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000};
     for (int k = 0; k < 1; ++k) {
         for (int j = 0; j < 2*padding + ny - 4; ++j) {
             for (int i = 0; i < 2*padding + nx - 4; ++i) {
                  #define _f(i,j) f[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  #define _df1(i,j) df1[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  _df1(-padding + i + 2,-padding + j + 2) = phy[0]*(px[0]*_f(-padding + i + 1,-padding + j) + px[1]*_f(-padding + i + 2,-padding + j) + px[2]*_f(-padding + i + 3,-padding + j) + px[3]*_f(-padding + i + 4,-padding + j)) + phy[1]*(px[0]*_f(-padding + i + 1,-padding + j + 1) + px[1]*_f(-padding + i + 2,-padding + j + 1) + px[2]*_f(-padding + i + 3,-padding + j + 1) + px[3]*_f(-padding + i + 4,-padding + j + 1)) + phy[2]*(px[0]*_f(-padding + i + 1,-padding + j + 2) + px[1]*_f(-padding + i + 2,-padding + j + 2) + px[2]*_f(-padding + i + 3,-padding + j + 2) + px[3]*_f(-padding + i + 4,-padding + j + 2)) + phy[3]*(px[0]*_f(-padding + i + 1,-padding + j + 3) + px[1]*_f(-padding + i + 2,-padding + j + 3) + px[2]*_f(-padding + i + 3,-padding + j + 3) + px[3]*_f(-padding + i + 4,-padding + j + 3));
                  #undef _f
                  #undef _df1
                  
             }
         }
     }
     
}

void metrics_f_diff_1_1_111(float *df1, const float *f, const float hi, const int nx, const int ny, const int nz)
{
     const float dhx[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     for (int k = 0; k < 1; ++k) {
         for (int j = 0; j < 2*padding + ny - 4; ++j) {
             for (int i = 0; i < 2*padding + nx - 4; ++i) {
                  #define _f(i,j) f[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  #define _df1(i,j) df1[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  _df1(-padding + i + 2,-padding + j + 2) = hi*(dhx[0]*_f(-padding + i,-padding + j + 2) + dhx[1]*_f(-padding + i + 1,-padding + j + 2) + dhx[2]*_f(-padding + i + 2,-padding + j + 2) + dhx[3]*_f(-padding + i + 3,-padding + j + 2));
                  #undef _f
                  #undef _df1
                  
             }
         }
     }
     
}

void metrics_f_diff_1_2_111(float *df1, const float *f, const float hi, const int nx, const int ny, const int nz)
{
     const float dx[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     for (int k = 0; k < 1; ++k) {
         for (int j = 0; j < 2*padding + ny - 4; ++j) {
             for (int i = 0; i < 2*padding + nx - 4; ++i) {
                  #define _f(i,j) f[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  #define _df1(i,j) df1[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  _df1(-padding + i + 2,-padding + j + 2) = hi*(dx[0]*_f(-padding + i + 1,-padding + j + 2) + dx[1]*_f(-padding + i + 2,-padding + j + 2) + dx[2]*_f(-padding + i + 3,-padding + j + 2) + dx[3]*_f(-padding + i + 4,-padding + j + 2));
                  #undef _f
                  #undef _df1
                  
             }
         }
     }
     
}

void metrics_f_diff_2_1_111(float *df1, const float *f, const float hi, const int nx, const int ny, const int nz)
{
     const float dhy[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     for (int k = 0; k < 1; ++k) {
         for (int j = 0; j < 2*padding + ny - 4; ++j) {
             for (int i = 0; i < 2*padding + nx - 4; ++i) {
                  #define _f(i,j) f[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  #define _df1(i,j) df1[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  _df1(-padding + i + 2,-padding + j + 2) = hi*(dhy[0]*_f(-padding + i + 2,-padding + j) + dhy[1]*_f(-padding + i + 2,-padding + j + 1) + dhy[2]*_f(-padding + i + 2,-padding + j + 2) + dhy[3]*_f(-padding + i + 2,-padding + j + 3));
                  #undef _f
                  #undef _df1
                  
             }
         }
     }
     
}

void metrics_f_diff_2_2_111(float *df1, const float *f, const float hi, const int nx, const int ny, const int nz)
{
     const float dy[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     for (int k = 0; k < 1; ++k) {
         for (int j = 0; j < 2*padding + ny - 4; ++j) {
             for (int i = 0; i < 2*padding + nx - 4; ++i) {
                  #define _f(i,j) f[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  #define _df1(i,j) df1[(j) + align + padding + ((i) + padding + 2)*(2*align + 2*padding + ny + 4) + 2]
                  _df1(-padding + i + 2,-padding + j + 2) = hi*(dy[0]*_f(-padding + i + 2,-padding + j + 1) + dy[1]*_f(-padding + i + 2,-padding + j + 2) + dy[2]*_f(-padding + i + 2,-padding + j + 3) + dy[3]*_f(-padding + i + 2,-padding + j + 4));
                  #undef _f
                  #undef _df1
                  
             }
         }
     }
     
}

void metrics_g_interp_110(float *g3, const float *g, const int nx, const int ny, const int nz)
{
     const float phzl[6][7] = {{0.8338228784688313, 0.1775123316429260, 0.1435067013076542, -0.1548419114194114, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.1813404047323969, 1.1246711188154426, -0.2933634518280757, -0.0126480717197637, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {-0.1331142706282399, 0.7930714675884345, 0.3131998767078508, 0.0268429263319546, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0969078556633046, -0.1539344946680898, 0.4486491202844389, 0.6768738207821733, -0.0684963020618270, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, -0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000}};
     for (int k = 0; k < 6; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(k) = phzl[k][0]*_g(0) + phzl[k][1]*_g(1) + phzl[k][2]*_g(2) + phzl[k][3]*_g(3) + phzl[k][4]*_g(4) + phzl[k][5]*_g(5) + phzl[k][6]*_g(6);
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_interp_111(float *g3, const float *g, const int nx, const int ny, const int nz)
{
     const float phz[4] = {-0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000};
     for (int k = 0; k < nz - 12; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(k + 6) = phz[0]*_g(k + 4) + phz[1]*_g(k + 5) + phz[2]*_g(k + 6) + phz[3]*_g(k + 7);
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_interp_112(float *g3, const float *g, const int nx, const int ny, const int nz)
{
     const float phzr[6][8] = {{0.0000000000000000, 0.8338228784688313, 0.1775123316429260, 0.1435067013076542, -0.1548419114194114, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.1813404047323969, 1.1246711188154426, -0.2933634518280757, -0.0126480717197637, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, -0.1331142706282399, 0.7930714675884345, 0.3131998767078508, 0.0268429263319546, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0969078556633046, -0.1539344946680898, 0.4486491202844389, 0.6768738207821733, -0.0684963020618270, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000}};
     for (int k = 0; k < 6; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(nz - 1 - k) = phzr[k][7]*_g(nz - 8) + phzr[k][6]*_g(nz - 7) + phzr[k][5]*_g(nz - 6) + phzr[k][4]*_g(nz - 5) + phzr[k][3]*_g(nz - 4) + phzr[k][2]*_g(nz - 3) + phzr[k][1]*_g(nz - 2) + phzr[k][0]*_g(nz - 1);
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_diff_3_110(float *g3, const float *g, const float hi, const int nx, const int ny, const int nz)
{
     const float dzl[6][8] = {{-1.7779989465546748, 1.3337480247900155, 0.7775013168066564, -0.3332503950419969, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {-0.4410217341392059, -0.1730842484889890, 0.4487228323259926, 0.1653831503022022, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.1798793213882701, -0.2757257254150788, -0.9597948548284453, 1.1171892610431817, -0.0615480021879277, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0153911381507088, 0.0568851455503591, -0.1998976464597171, -0.8628231468598346, 1.0285385292191949, -0.0380940196007109, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667}};
     for (int k = 0; k < 6; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(k) = hi*(dzl[k][0]*_g(0) + dzl[k][1]*_g(1) + dzl[k][2]*_g(2) + dzl[k][3]*_g(3) + dzl[k][4]*_g(4) + dzl[k][5]*_g(5) + dzl[k][6]*_g(6) + dzl[k][7]*_g(7));
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_diff_3_111(float *g3, const float *g, const float hi, const int nx, const int ny, const int nz)
{
     const float dz[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     for (int k = 0; k < nz - 12; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(k + 6) = hi*(dz[0]*_g(k + 5) + dz[1]*_g(k + 6) + dz[2]*_g(k + 7) + dz[3]*_g(k + 8));
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_diff_3_112(float *g3, const float *g, const float hi, const int nx, const int ny, const int nz)
{
     const float dzr[6][7] = {{0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {1.7779989465546748, -1.3337480247900155, -0.7775013168066564, 0.3332503950419969, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.4410217341392059, 0.1730842484889890, -0.4487228323259926, -0.1653831503022022, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {-0.1798793213882701, 0.2757257254150788, 0.9597948548284453, -1.1171892610431817, 0.0615480021879277, 0.0000000000000000, 0.0000000000000000}, {-0.0153911381507088, -0.0568851455503591, 0.1998976464597171, 0.8628231468598346, -1.0285385292191949, 0.0380940196007109, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0416666666666667, 1.1250000000000000, -1.1250000000000000, 0.0416666666666667}};
     for (int k = 0; k < 6; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(nz - 1 - k) = hi*(dzr[k][6]*_g(nz - 7) + dzr[k][5]*_g(nz - 6) + dzr[k][4]*_g(nz - 5) + dzr[k][3]*_g(nz - 4) + dzr[k][2]*_g(nz - 3) + dzr[k][1]*_g(nz - 2) + dzr[k][0]*_g(nz - 1));
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_diff_c_110(float *g3, const float *g, const float hi, const int nx, const int ny, const int nz)
{
     const float dhzl[6][7] = {{-1.4511412472637157, 1.8534237417911470, -0.3534237417911469, -0.0488587527362844, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {-0.8577143189081458, 0.5731429567244373, 0.4268570432755628, -0.1422856810918542, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {-0.1674548505882877, -0.4976354482351368, 0.4976354482351368, 0.1674548505882877, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.1027061113405124, -0.2624541326469860, -0.8288742701021167, 1.0342864927831414, -0.0456642013745513, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667}};
     for (int k = 0; k < 6; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(k) = hi*(dhzl[k][0]*_g(0) + dhzl[k][1]*_g(1) + dhzl[k][2]*_g(2) + dhzl[k][3]*_g(3) + dhzl[k][4]*_g(4) + dhzl[k][5]*_g(5) + dhzl[k][6]*_g(6));
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_diff_c_111(float *g3, const float *g, const float hi, const int nx, const int ny, const int nz)
{
     const float dhz[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     for (int k = 0; k < nz - 12; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(k + 6) = hi*(dhz[0]*_g(k + 4) + dhz[1]*_g(k + 5) + dhz[2]*_g(k + 6) + dhz[3]*_g(k + 7));
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

void metrics_g_diff_c_112(float *g3, const float *g, const float hi, const int nx, const int ny, const int nz)
{
     const float dhzr[6][8] = {{0.0000000000000000, 1.4511412472637157, -1.8534237417911470, 0.3534237417911469, 0.0488587527362844, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.8577143189081458, -0.5731429567244373, -0.4268570432755628, 0.1422856810918542, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.1674548505882877, 0.4976354482351368, -0.4976354482351368, -0.1674548505882877, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, -0.1027061113405124, 0.2624541326469860, 0.8288742701021167, -1.0342864927831414, 0.0456642013745513, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0416666666666667, 1.1250000000000000, -1.1250000000000000, 0.0416666666666667, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0416666666666667, 1.1250000000000000, -1.1250000000000000, 0.0416666666666667}};
     for (int k = 0; k < 6; ++k) {
         for (int j = 0; j < 1; ++j) {
             for (int i = 0; i < 1; ++i) {
                  #define _g(k) g[(k) + align]
                  #define _g3(k) g3[(k) + align]
                  _g3(nz - 1 - k) = hi*(dhzr[k][7]*_g(nz - 8) + dhzr[k][6]*_g(nz - 7) + dhzr[k][5]*_g(nz - 6) + dhzr[k][4]*_g(nz - 5) + dhzr[k][3]*_g(nz - 4) + dhzr[k][2]*_g(nz - 3) + dhzr[k][1]*_g(nz - 2) + dhzr[k][0]*_g(nz - 1));
                  #undef _g
                  #undef _g3
                  
             }
         }
     }
     
}

#undef padding
