#include "cutopography_kernel.cuh"

__global__ void dtopo_vel_110(
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *rho,
    const float *s11, const float *s12, const float *s13, const float *s22,
    const float *s23, const float *s33, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bi, const int bj,
    const int ei, const int ej) {
  const float phzl[6][7] = {
      {0.8338228784688313, 0.1775123316429260, 0.1435067013076542,
       -0.1548419114194114, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.1813404047323969, 1.1246711188154426, -0.2933634518280757,
       -0.0126480717197637, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1331142706282399, 0.7930714675884345, 0.3131998767078508,
       0.0268429263319546, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.0969078556633046, -0.1539344946680898, 0.4486491202844389,
       0.6768738207821733, -0.0684963020618270, 0.0000000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, -0.0625000000000000,
       0.5625000000000000, 0.5625000000000000, -0.0625000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0625000000000000, 0.5625000000000000, 0.5625000000000000,
       -0.0625000000000000}};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float dhpzl[6][9] = {
      {-1.4276800979942257, 0.2875185051606178, 2.0072491465276454,
       -0.8773816261307504, 0.0075022330101095, 0.0027918394266035,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.8139439685257414, -0.1273679143938725, 1.1932750007455708,
       -0.1475120181828087, -0.1125814499297686, 0.0081303502866204,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.1639182541610305, -0.3113839909089031, 0.0536007135209480,
       0.3910958927076031, 0.0401741813821989, -0.0095685425408165,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.0171478318814576, 0.0916600077207278, -0.7187220404622644,
       0.1434031863528334, 0.5827389738506837, -0.0847863081664324,
       0.0028540125859095, 0.0000000000000000, 0.0000000000000000},
      {0.0579176640853654, -0.0022069616616207, -0.0108792602269819,
       -0.6803612607837533, 0.0530169938441241, 0.6736586580761996,
       -0.0937500000000000, 0.0026041666666667, 0.0000000000000000},
      {-0.0020323834153791, -0.0002106933140862, 0.0013351454085978,
       0.0938400881871787, -0.6816971139746001, 0.0002232904416222,
       0.6796875000000000, -0.0937500000000000, 0.0026041666666667}};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhzl[6][7] = {
      {-1.4511412472637157, 1.8534237417911470, -0.3534237417911469,
       -0.0488587527362844, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.8577143189081458, 0.5731429567244373, 0.4268570432755628,
       -0.1422856810918542, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1674548505882877, -0.4976354482351368, 0.4976354482351368,
       0.1674548505882877, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.1027061113405124, -0.2624541326469860, -0.8288742701021167,
       1.0342864927831414, -0.0456642013745513, 0.0000000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0416666666666667,
       -1.1250000000000000, 1.1250000000000000, -0.0416666666666667,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0416666666666667, -1.1250000000000000, 1.1250000000000000,
       -0.0416666666666667}};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dphzl[6][9] = {
      {-1.3764648947859957, 1.8523239861274134, -0.5524268681758195,
       0.0537413571133823, 0.0228264197210198, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.4428256655817484, 0.0574614517751293, 0.2022259589759502,
       0.1944663890497050, -0.0113281342190362, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.3360140866060757, -1.2113298407847195, 0.3111668377093505,
       0.6714462506479003, -0.1111440843153523, 0.0038467501367455,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.0338560531369653, 0.0409943223643901, -0.5284757132923059,
       -0.0115571196122084, 0.6162252315536445, -0.0857115441015996,
       0.0023808762250444, 0.0000000000000000, 0.0000000000000000},
      {0.0040378273193044, -0.0064139372778371, 0.0890062133451850,
       -0.6749219241340761, -0.0002498459192428, 0.6796875000000000,
       -0.0937500000000000, 0.0026041666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, -0.0026041666666667,
       0.0937500000000000, -0.6796875000000000, 0.0000000000000000,
       0.6796875000000000, -0.0937500000000000, 0.0026041666666667}};
  const float dzl[6][8] = {
      {-1.7779989465546748, 1.3337480247900155, 0.7775013168066564,
       -0.3332503950419969, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {-0.4410217341392059, -0.1730842484889890, 0.4487228323259926,
       0.1653831503022022, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.1798793213882701, -0.2757257254150788, -0.9597948548284453,
       1.1171892610431817, -0.0615480021879277, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0153911381507088, 0.0568851455503591, -0.1998976464597171,
       -0.8628231468598346, 1.0285385292191949, -0.0380940196007109,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0416666666666667, -1.1250000000000000, 1.1250000000000000,
       -0.0416666666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0416666666666667, -1.1250000000000000,
       1.1250000000000000, -0.0416666666666667}};
  const int i = threadIdx.x + blockIdx.x * blockDim.x + bi;
  if (i >= nx)
    return;
  if (i >= ei)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= 6)
    return;
#define _rho(i, j, k)                                                          \
  rho[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
  float rho1 =
      phzl[k][0] * (phy[2] * _rho(i, j, 0) + phy[0] * _rho(i, j - 2, 0) +
                    phy[1] * _rho(i, j - 1, 0) + phy[3] * _rho(i, j + 1, 0)) +
      phzl[k][1] * (phy[2] * _rho(i, j, 1) + phy[0] * _rho(i, j - 2, 1) +
                    phy[1] * _rho(i, j - 1, 1) + phy[3] * _rho(i, j + 1, 1)) +
      phzl[k][2] * (phy[2] * _rho(i, j, 2) + phy[0] * _rho(i, j - 2, 2) +
                    phy[1] * _rho(i, j - 1, 2) + phy[3] * _rho(i, j + 1, 2)) +
      phzl[k][3] * (phy[2] * _rho(i, j, 3) + phy[0] * _rho(i, j - 2, 3) +
                    phy[1] * _rho(i, j - 1, 3) + phy[3] * _rho(i, j + 1, 3)) +
      phzl[k][4] * (phy[2] * _rho(i, j, 4) + phy[0] * _rho(i, j - 2, 4) +
                    phy[1] * _rho(i, j - 1, 4) + phy[3] * _rho(i, j + 1, 4)) +
      phzl[k][5] * (phy[2] * _rho(i, j, 5) + phy[0] * _rho(i, j - 2, 5) +
                    phy[1] * _rho(i, j - 1, 5) + phy[3] * _rho(i, j + 1, 5)) +
      phzl[k][6] * (phy[2] * _rho(i, j, 6) + phy[0] * _rho(i, j - 2, 6) +
                    phy[1] * _rho(i, j - 1, 6) + phy[3] * _rho(i, j + 1, 6));
  float rho2 =
      phzl[k][0] * (phx[2] * _rho(i, j, 0) + phx[0] * _rho(i - 2, j, 0) +
                    phx[1] * _rho(i - 1, j, 0) + phx[3] * _rho(i + 1, j, 0)) +
      phzl[k][1] * (phx[2] * _rho(i, j, 1) + phx[0] * _rho(i - 2, j, 1) +
                    phx[1] * _rho(i - 1, j, 1) + phx[3] * _rho(i + 1, j, 1)) +
      phzl[k][2] * (phx[2] * _rho(i, j, 2) + phx[0] * _rho(i - 2, j, 2) +
                    phx[1] * _rho(i - 1, j, 2) + phx[3] * _rho(i + 1, j, 2)) +
      phzl[k][3] * (phx[2] * _rho(i, j, 3) + phx[0] * _rho(i - 2, j, 3) +
                    phx[1] * _rho(i - 1, j, 3) + phx[3] * _rho(i + 1, j, 3)) +
      phzl[k][4] * (phx[2] * _rho(i, j, 4) + phx[0] * _rho(i - 2, j, 4) +
                    phx[1] * _rho(i - 1, j, 4) + phx[3] * _rho(i + 1, j, 4)) +
      phzl[k][5] * (phx[2] * _rho(i, j, 5) + phx[0] * _rho(i - 2, j, 5) +
                    phx[1] * _rho(i - 1, j, 5) + phx[3] * _rho(i + 1, j, 5)) +
      phzl[k][6] * (phx[2] * _rho(i, j, 6) + phx[0] * _rho(i - 2, j, 6) +
                    phx[1] * _rho(i - 1, j, 6) + phx[3] * _rho(i + 1, j, 6));
  float rho3 =
      phy[2] * (phx[2] * _rho(i, j, k) + phx[0] * _rho(i - 2, j, k) +
                phx[1] * _rho(i - 1, j, k) + phx[3] * _rho(i + 1, j, k)) +
      phy[0] *
          (phx[2] * _rho(i, j - 2, k) + phx[0] * _rho(i - 2, j - 2, k) +
           phx[1] * _rho(i - 1, j - 2, k) + phx[3] * _rho(i + 1, j - 2, k)) +
      phy[1] *
          (phx[2] * _rho(i, j - 1, k) + phx[0] * _rho(i - 2, j - 1, k) +
           phx[1] * _rho(i - 1, j - 1, k) + phx[3] * _rho(i + 1, j - 1, k)) +
      phy[3] *
          (phx[2] * _rho(i, j + 1, k) + phx[0] * _rho(i - 2, j + 1, k) +
           phx[1] * _rho(i - 1, j + 1, k) + phx[3] * _rho(i + 1, j + 1, k));
  float Ai1 = _f_1(i, j) * _g3_c(k) * rho1;
  Ai1 = nu * 1.0 / Ai1;
  float Ai2 = _f_2(i, j) * _g3_c(k) * rho2;
  Ai2 = nu * 1.0 / Ai2;
  float Ai3 = _f_c(i, j) * _g3(k) * rho3;
  Ai3 = nu * 1.0 / Ai3;
  float f_dcrj = _dcrjx(i) * _dcrjy(j) * _dcrjz(k);
  _u1(i, j, k) =
      (a * _u1(i, j, k) +
       Ai1 *
           (dhx[2] * _f_c(i, j) * _g3_c(k) * _s11(i, j, k) +
            dhx[0] * _f_c(i - 2, j) * _g3_c(k) * _s11(i - 2, j, k) +
            dhx[1] * _f_c(i - 1, j) * _g3_c(k) * _s11(i - 1, j, k) +
            dhx[3] * _f_c(i + 1, j) * _g3_c(k) * _s11(i + 1, j, k) +
            dhy[2] * _f(i, j) * _g3_c(k) * _s12(i, j, k) +
            dhy[0] * _f(i, j - 2) * _g3_c(k) * _s12(i, j - 2, k) +
            dhy[1] * _f(i, j - 1) * _g3_c(k) * _s12(i, j - 1, k) +
            dhy[3] * _f(i, j + 1) * _g3_c(k) * _s12(i, j + 1, k) +
            dhzl[k][0] * _s13(i, j, 0) + dhzl[k][1] * _s13(i, j, 1) +
            dhzl[k][2] * _s13(i, j, 2) + dhzl[k][3] * _s13(i, j, 3) +
            dhzl[k][4] * _s13(i, j, 4) + dhzl[k][5] * _s13(i, j, 5) +
            dhzl[k][6] * _s13(i, j, 6) -
            _f1_1(i, j) *
                (dhpzl[k][0] * _g_c(0) *
                     (phx[2] * _s11(i, j, 0) + phx[0] * _s11(i - 2, j, 0) +
                      phx[1] * _s11(i - 1, j, 0) + phx[3] * _s11(i + 1, j, 0)) +
                 dhpzl[k][1] * _g_c(1) *
                     (phx[2] * _s11(i, j, 1) + phx[0] * _s11(i - 2, j, 1) +
                      phx[1] * _s11(i - 1, j, 1) + phx[3] * _s11(i + 1, j, 1)) +
                 dhpzl[k][2] * _g_c(2) *
                     (phx[2] * _s11(i, j, 2) + phx[0] * _s11(i - 2, j, 2) +
                      phx[1] * _s11(i - 1, j, 2) + phx[3] * _s11(i + 1, j, 2)) +
                 dhpzl[k][3] * _g_c(3) *
                     (phx[2] * _s11(i, j, 3) + phx[0] * _s11(i - 2, j, 3) +
                      phx[1] * _s11(i - 1, j, 3) + phx[3] * _s11(i + 1, j, 3)) +
                 dhpzl[k][4] * _g_c(4) *
                     (phx[2] * _s11(i, j, 4) + phx[0] * _s11(i - 2, j, 4) +
                      phx[1] * _s11(i - 1, j, 4) + phx[3] * _s11(i + 1, j, 4)) +
                 dhpzl[k][5] * _g_c(5) *
                     (phx[2] * _s11(i, j, 5) + phx[0] * _s11(i - 2, j, 5) +
                      phx[1] * _s11(i - 1, j, 5) + phx[3] * _s11(i + 1, j, 5)) +
                 dhpzl[k][6] * _g_c(6) *
                     (phx[2] * _s11(i, j, 6) + phx[0] * _s11(i - 2, j, 6) +
                      phx[1] * _s11(i - 1, j, 6) + phx[3] * _s11(i + 1, j, 6)) +
                 dhpzl[k][7] * _g_c(7) *
                     (phx[2] * _s11(i, j, 7) + phx[0] * _s11(i - 2, j, 7) +
                      phx[1] * _s11(i - 1, j, 7) + phx[3] * _s11(i + 1, j, 7)) +
                 dhpzl[k][8] * _g_c(8) *
                     (phx[2] * _s11(i, j, 8) + phx[0] * _s11(i - 2, j, 8) +
                      phx[1] * _s11(i - 1, j, 8) +
                      phx[3] * _s11(i + 1, j, 8))) -
            _f2_1(i, j) *
                (dhpzl[k][0] * _g_c(0) *
                     (phy[2] * _s12(i, j, 0) + phy[0] * _s12(i, j - 2, 0) +
                      phy[1] * _s12(i, j - 1, 0) + phy[3] * _s12(i, j + 1, 0)) +
                 dhpzl[k][1] * _g_c(1) *
                     (phy[2] * _s12(i, j, 1) + phy[0] * _s12(i, j - 2, 1) +
                      phy[1] * _s12(i, j - 1, 1) + phy[3] * _s12(i, j + 1, 1)) +
                 dhpzl[k][2] * _g_c(2) *
                     (phy[2] * _s12(i, j, 2) + phy[0] * _s12(i, j - 2, 2) +
                      phy[1] * _s12(i, j - 1, 2) + phy[3] * _s12(i, j + 1, 2)) +
                 dhpzl[k][3] * _g_c(3) *
                     (phy[2] * _s12(i, j, 3) + phy[0] * _s12(i, j - 2, 3) +
                      phy[1] * _s12(i, j - 1, 3) + phy[3] * _s12(i, j + 1, 3)) +
                 dhpzl[k][4] * _g_c(4) *
                     (phy[2] * _s12(i, j, 4) + phy[0] * _s12(i, j - 2, 4) +
                      phy[1] * _s12(i, j - 1, 4) + phy[3] * _s12(i, j + 1, 4)) +
                 dhpzl[k][5] * _g_c(5) *
                     (phy[2] * _s12(i, j, 5) + phy[0] * _s12(i, j - 2, 5) +
                      phy[1] * _s12(i, j - 1, 5) + phy[3] * _s12(i, j + 1, 5)) +
                 dhpzl[k][6] * _g_c(6) *
                     (phy[2] * _s12(i, j, 6) + phy[0] * _s12(i, j - 2, 6) +
                      phy[1] * _s12(i, j - 1, 6) + phy[3] * _s12(i, j + 1, 6)) +
                 dhpzl[k][7] * _g_c(7) *
                     (phy[2] * _s12(i, j, 7) + phy[0] * _s12(i, j - 2, 7) +
                      phy[1] * _s12(i, j - 1, 7) + phy[3] * _s12(i, j + 1, 7)) +
                 dhpzl[k][8] * _g_c(8) *
                     (phy[2] * _s12(i, j, 8) + phy[0] * _s12(i, j - 2, 8) +
                      phy[1] * _s12(i, j - 1, 8) +
                      phy[3] * _s12(i, j + 1, 8))))) *
      f_dcrj;
  _u2(i, j, k) =
      (a * _u2(i, j, k) +
       Ai2 *
           (dhzl[k][0] * _s23(i, j, 0) + dhzl[k][1] * _s23(i, j, 1) +
            dhzl[k][2] * _s23(i, j, 2) + dhzl[k][3] * _s23(i, j, 3) +
            dhzl[k][4] * _s23(i, j, 4) + dhzl[k][5] * _s23(i, j, 5) +
            dhzl[k][6] * _s23(i, j, 6) +
            dx[1] * _f(i, j) * _g3_c(k) * _s12(i, j, k) +
            dx[0] * _f(i - 1, j) * _g3_c(k) * _s12(i - 1, j, k) +
            dx[2] * _f(i + 1, j) * _g3_c(k) * _s12(i + 1, j, k) +
            dx[3] * _f(i + 2, j) * _g3_c(k) * _s12(i + 2, j, k) +
            dy[1] * _f_c(i, j) * _g3_c(k) * _s22(i, j, k) +
            dy[0] * _f_c(i, j - 1) * _g3_c(k) * _s22(i, j - 1, k) +
            dy[2] * _f_c(i, j + 1) * _g3_c(k) * _s22(i, j + 1, k) +
            dy[3] * _f_c(i, j + 2) * _g3_c(k) * _s22(i, j + 2, k) -
            _f1_2(i, j) *
                (dhpzl[k][0] * _g_c(0) *
                     (px[1] * _s12(i, j, 0) + px[0] * _s12(i - 1, j, 0) +
                      px[2] * _s12(i + 1, j, 0) + px[3] * _s12(i + 2, j, 0)) +
                 dhpzl[k][1] * _g_c(1) *
                     (px[1] * _s12(i, j, 1) + px[0] * _s12(i - 1, j, 1) +
                      px[2] * _s12(i + 1, j, 1) + px[3] * _s12(i + 2, j, 1)) +
                 dhpzl[k][2] * _g_c(2) *
                     (px[1] * _s12(i, j, 2) + px[0] * _s12(i - 1, j, 2) +
                      px[2] * _s12(i + 1, j, 2) + px[3] * _s12(i + 2, j, 2)) +
                 dhpzl[k][3] * _g_c(3) *
                     (px[1] * _s12(i, j, 3) + px[0] * _s12(i - 1, j, 3) +
                      px[2] * _s12(i + 1, j, 3) + px[3] * _s12(i + 2, j, 3)) +
                 dhpzl[k][4] * _g_c(4) *
                     (px[1] * _s12(i, j, 4) + px[0] * _s12(i - 1, j, 4) +
                      px[2] * _s12(i + 1, j, 4) + px[3] * _s12(i + 2, j, 4)) +
                 dhpzl[k][5] * _g_c(5) *
                     (px[1] * _s12(i, j, 5) + px[0] * _s12(i - 1, j, 5) +
                      px[2] * _s12(i + 1, j, 5) + px[3] * _s12(i + 2, j, 5)) +
                 dhpzl[k][6] * _g_c(6) *
                     (px[1] * _s12(i, j, 6) + px[0] * _s12(i - 1, j, 6) +
                      px[2] * _s12(i + 1, j, 6) + px[3] * _s12(i + 2, j, 6)) +
                 dhpzl[k][7] * _g_c(7) *
                     (px[1] * _s12(i, j, 7) + px[0] * _s12(i - 1, j, 7) +
                      px[2] * _s12(i + 1, j, 7) + px[3] * _s12(i + 2, j, 7)) +
                 dhpzl[k][8] * _g_c(8) *
                     (px[1] * _s12(i, j, 8) + px[0] * _s12(i - 1, j, 8) +
                      px[2] * _s12(i + 1, j, 8) + px[3] * _s12(i + 2, j, 8))) -
            _f2_2(i, j) *
                (dhpzl[k][0] * _g_c(0) *
                     (py[1] * _s22(i, j, 0) + py[0] * _s22(i, j - 1, 0) +
                      py[2] * _s22(i, j + 1, 0) + py[3] * _s22(i, j + 2, 0)) +
                 dhpzl[k][1] * _g_c(1) *
                     (py[1] * _s22(i, j, 1) + py[0] * _s22(i, j - 1, 1) +
                      py[2] * _s22(i, j + 1, 1) + py[3] * _s22(i, j + 2, 1)) +
                 dhpzl[k][2] * _g_c(2) *
                     (py[1] * _s22(i, j, 2) + py[0] * _s22(i, j - 1, 2) +
                      py[2] * _s22(i, j + 1, 2) + py[3] * _s22(i, j + 2, 2)) +
                 dhpzl[k][3] * _g_c(3) *
                     (py[1] * _s22(i, j, 3) + py[0] * _s22(i, j - 1, 3) +
                      py[2] * _s22(i, j + 1, 3) + py[3] * _s22(i, j + 2, 3)) +
                 dhpzl[k][4] * _g_c(4) *
                     (py[1] * _s22(i, j, 4) + py[0] * _s22(i, j - 1, 4) +
                      py[2] * _s22(i, j + 1, 4) + py[3] * _s22(i, j + 2, 4)) +
                 dhpzl[k][5] * _g_c(5) *
                     (py[1] * _s22(i, j, 5) + py[0] * _s22(i, j - 1, 5) +
                      py[2] * _s22(i, j + 1, 5) + py[3] * _s22(i, j + 2, 5)) +
                 dhpzl[k][6] * _g_c(6) *
                     (py[1] * _s22(i, j, 6) + py[0] * _s22(i, j - 1, 6) +
                      py[2] * _s22(i, j + 1, 6) + py[3] * _s22(i, j + 2, 6)) +
                 dhpzl[k][7] * _g_c(7) *
                     (py[1] * _s22(i, j, 7) + py[0] * _s22(i, j - 1, 7) +
                      py[2] * _s22(i, j + 1, 7) + py[3] * _s22(i, j + 2, 7)) +
                 dhpzl[k][8] * _g_c(8) *
                     (py[1] * _s22(i, j, 8) + py[0] * _s22(i, j - 1, 8) +
                      py[2] * _s22(i, j + 1, 8) +
                      py[3] * _s22(i, j + 2, 8))))) *
      f_dcrj;
  _u3(i, j, k) =
      (a * _u3(i, j, k) +
       Ai3 *
           (dhy[2] * _f_2(i, j) * _g3(k) * _s23(i, j, k) +
            dhy[0] * _f_2(i, j - 2) * _g3(k) * _s23(i, j - 2, k) +
            dhy[1] * _f_2(i, j - 1) * _g3(k) * _s23(i, j - 1, k) +
            dhy[3] * _f_2(i, j + 1) * _g3(k) * _s23(i, j + 1, k) +
            dx[1] * _f_1(i, j) * _g3(k) * _s13(i, j, k) +
            dx[0] * _f_1(i - 1, j) * _g3(k) * _s13(i - 1, j, k) +
            dx[2] * _f_1(i + 1, j) * _g3(k) * _s13(i + 1, j, k) +
            dx[3] * _f_1(i + 2, j) * _g3(k) * _s13(i + 2, j, k) +
            dzl[k][0] * _s33(i, j, 0) + dzl[k][1] * _s33(i, j, 1) +
            dzl[k][2] * _s33(i, j, 2) + dzl[k][3] * _s33(i, j, 3) +
            dzl[k][4] * _s33(i, j, 4) + dzl[k][5] * _s33(i, j, 5) +
            dzl[k][6] * _s33(i, j, 6) + dzl[k][7] * _s33(i, j, 7) -
            _f1_c(i, j) *
                (dphzl[k][0] * _g(0) *
                     (px[1] * _s13(i, j, 0) + px[0] * _s13(i - 1, j, 0) +
                      px[2] * _s13(i + 1, j, 0) + px[3] * _s13(i + 2, j, 0)) +
                 dphzl[k][1] * _g(1) *
                     (px[1] * _s13(i, j, 1) + px[0] * _s13(i - 1, j, 1) +
                      px[2] * _s13(i + 1, j, 1) + px[3] * _s13(i + 2, j, 1)) +
                 dphzl[k][2] * _g(2) *
                     (px[1] * _s13(i, j, 2) + px[0] * _s13(i - 1, j, 2) +
                      px[2] * _s13(i + 1, j, 2) + px[3] * _s13(i + 2, j, 2)) +
                 dphzl[k][3] * _g(3) *
                     (px[1] * _s13(i, j, 3) + px[0] * _s13(i - 1, j, 3) +
                      px[2] * _s13(i + 1, j, 3) + px[3] * _s13(i + 2, j, 3)) +
                 dphzl[k][4] * _g(4) *
                     (px[1] * _s13(i, j, 4) + px[0] * _s13(i - 1, j, 4) +
                      px[2] * _s13(i + 1, j, 4) + px[3] * _s13(i + 2, j, 4)) +
                 dphzl[k][5] * _g(5) *
                     (px[1] * _s13(i, j, 5) + px[0] * _s13(i - 1, j, 5) +
                      px[2] * _s13(i + 1, j, 5) + px[3] * _s13(i + 2, j, 5)) +
                 dphzl[k][6] * _g(6) *
                     (px[1] * _s13(i, j, 6) + px[0] * _s13(i - 1, j, 6) +
                      px[2] * _s13(i + 1, j, 6) + px[3] * _s13(i + 2, j, 6)) +
                 dphzl[k][7] * _g(7) *
                     (px[1] * _s13(i, j, 7) + px[0] * _s13(i - 1, j, 7) +
                      px[2] * _s13(i + 1, j, 7) + px[3] * _s13(i + 2, j, 7)) +
                 dphzl[k][8] * _g(8) *
                     (px[1] * _s13(i, j, 8) + px[0] * _s13(i - 1, j, 8) +
                      px[2] * _s13(i + 1, j, 8) + px[3] * _s13(i + 2, j, 8))) -
            _f2_c(i, j) *
                (dphzl[k][0] * _g(0) *
                     (phy[2] * _s23(i, j, 0) + phy[0] * _s23(i, j - 2, 0) +
                      phy[1] * _s23(i, j - 1, 0) + phy[3] * _s23(i, j + 1, 0)) +
                 dphzl[k][1] * _g(1) *
                     (phy[2] * _s23(i, j, 1) + phy[0] * _s23(i, j - 2, 1) +
                      phy[1] * _s23(i, j - 1, 1) + phy[3] * _s23(i, j + 1, 1)) +
                 dphzl[k][2] * _g(2) *
                     (phy[2] * _s23(i, j, 2) + phy[0] * _s23(i, j - 2, 2) +
                      phy[1] * _s23(i, j - 1, 2) + phy[3] * _s23(i, j + 1, 2)) +
                 dphzl[k][3] * _g(3) *
                     (phy[2] * _s23(i, j, 3) + phy[0] * _s23(i, j - 2, 3) +
                      phy[1] * _s23(i, j - 1, 3) + phy[3] * _s23(i, j + 1, 3)) +
                 dphzl[k][4] * _g(4) *
                     (phy[2] * _s23(i, j, 4) + phy[0] * _s23(i, j - 2, 4) +
                      phy[1] * _s23(i, j - 1, 4) + phy[3] * _s23(i, j + 1, 4)) +
                 dphzl[k][5] * _g(5) *
                     (phy[2] * _s23(i, j, 5) + phy[0] * _s23(i, j - 2, 5) +
                      phy[1] * _s23(i, j - 1, 5) + phy[3] * _s23(i, j + 1, 5)) +
                 dphzl[k][6] * _g(6) *
                     (phy[2] * _s23(i, j, 6) + phy[0] * _s23(i, j - 2, 6) +
                      phy[1] * _s23(i, j - 1, 6) + phy[3] * _s23(i, j + 1, 6)) +
                 dphzl[k][7] * _g(7) *
                     (phy[2] * _s23(i, j, 7) + phy[0] * _s23(i, j - 2, 7) +
                      phy[1] * _s23(i, j - 1, 7) + phy[3] * _s23(i, j + 1, 7)) +
                 dphzl[k][8] * _g(8) *
                     (phy[2] * _s23(i, j, 8) + phy[0] * _s23(i, j - 2, 8) +
                      phy[1] * _s23(i, j - 1, 8) +
                      phy[3] * _s23(i, j + 1, 8))))) *
      f_dcrj;
#undef _rho
#undef _f_1
#undef _g3_c
#undef _f_2
#undef _f_c
#undef _g3
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _f
#undef _s13
#undef _u1
#undef _s11
#undef _f2_1
#undef _f1_1
#undef _s12
#undef _g_c
#undef _s23
#undef _f2_2
#undef _s22
#undef _f1_2
#undef _u2
#undef _g
#undef _s33
#undef _f2_c
#undef _f1_c
#undef _u3
}

__global__ void dtopo_vel_111(
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *rho,
    const float *s11, const float *s12, const float *s13, const float *s22,
    const float *s23, const float *s33, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bi, const int bj,
    const int ei, const int ej) {
  const float phz[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float dhpz[7] = {-0.0026041666666667, 0.0937500000000000,
                         -0.6796875000000000, 0.0000000000000000,
                         0.6796875000000000,  -0.0937500000000000,
                         0.0026041666666667};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhz[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dphz[7] = {-0.0026041666666667, 0.0937500000000000,
                         -0.6796875000000000, 0.0000000000000000,
                         0.6796875000000000,  -0.0937500000000000,
                         0.0026041666666667};
  const float dz[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const int i = threadIdx.x + blockIdx.x * blockDim.x + bi;
  if (i >= nx)
    return;
  if (i >= ei)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= nz - 12)
    return;
#define _rho(i, j, k)                                                          \
  rho[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
  float rho1 =
      phz[0] *
          (phy[2] * _rho(i, j, k + 4) + phy[0] * _rho(i, j - 2, k + 4) +
           phy[1] * _rho(i, j - 1, k + 4) + phy[3] * _rho(i, j + 1, k + 4)) +
      phz[1] *
          (phy[2] * _rho(i, j, k + 5) + phy[0] * _rho(i, j - 2, k + 5) +
           phy[1] * _rho(i, j - 1, k + 5) + phy[3] * _rho(i, j + 1, k + 5)) +
      phz[2] *
          (phy[2] * _rho(i, j, k + 6) + phy[0] * _rho(i, j - 2, k + 6) +
           phy[1] * _rho(i, j - 1, k + 6) + phy[3] * _rho(i, j + 1, k + 6)) +
      phz[3] *
          (phy[2] * _rho(i, j, k + 7) + phy[0] * _rho(i, j - 2, k + 7) +
           phy[1] * _rho(i, j - 1, k + 7) + phy[3] * _rho(i, j + 1, k + 7));
  float rho2 =
      phz[0] *
          (phx[2] * _rho(i, j, k + 4) + phx[0] * _rho(i - 2, j, k + 4) +
           phx[1] * _rho(i - 1, j, k + 4) + phx[3] * _rho(i + 1, j, k + 4)) +
      phz[1] *
          (phx[2] * _rho(i, j, k + 5) + phx[0] * _rho(i - 2, j, k + 5) +
           phx[1] * _rho(i - 1, j, k + 5) + phx[3] * _rho(i + 1, j, k + 5)) +
      phz[2] *
          (phx[2] * _rho(i, j, k + 6) + phx[0] * _rho(i - 2, j, k + 6) +
           phx[1] * _rho(i - 1, j, k + 6) + phx[3] * _rho(i + 1, j, k + 6)) +
      phz[3] *
          (phx[2] * _rho(i, j, k + 7) + phx[0] * _rho(i - 2, j, k + 7) +
           phx[1] * _rho(i - 1, j, k + 7) + phx[3] * _rho(i + 1, j, k + 7));
  float rho3 =
      phy[2] *
          (phx[2] * _rho(i, j, k + 6) + phx[0] * _rho(i - 2, j, k + 6) +
           phx[1] * _rho(i - 1, j, k + 6) + phx[3] * _rho(i + 1, j, k + 6)) +
      phy[0] *
          (phx[2] * _rho(i, j - 2, k + 6) + phx[0] * _rho(i - 2, j - 2, k + 6) +
           phx[1] * _rho(i - 1, j - 2, k + 6) +
           phx[3] * _rho(i + 1, j - 2, k + 6)) +
      phy[1] *
          (phx[2] * _rho(i, j - 1, k + 6) + phx[0] * _rho(i - 2, j - 1, k + 6) +
           phx[1] * _rho(i - 1, j - 1, k + 6) +
           phx[3] * _rho(i + 1, j - 1, k + 6)) +
      phy[3] *
          (phx[2] * _rho(i, j + 1, k + 6) + phx[0] * _rho(i - 2, j + 1, k + 6) +
           phx[1] * _rho(i - 1, j + 1, k + 6) +
           phx[3] * _rho(i + 1, j + 1, k + 6));
  float Ai1 = _f_1(i, j) * _g3_c(k + 6) * rho1;
  Ai1 = nu * 1.0 / Ai1;
  float Ai2 = _f_2(i, j) * _g3_c(k + 6) * rho2;
  Ai2 = nu * 1.0 / Ai2;
  float Ai3 = _f_c(i, j) * _g3(k + 6) * rho3;
  Ai3 = nu * 1.0 / Ai3;
  float f_dcrj = _dcrjx(i) * _dcrjy(j) * _dcrjz(k + 6);
  _u1(i, j, k + 6) =
      (a * _u1(i, j, k + 6) +
       Ai1 * (dhx[2] * _f_c(i, j) * _g3_c(k + 6) * _s11(i, j, k + 6) +
              dhx[0] * _f_c(i - 2, j) * _g3_c(k + 6) * _s11(i - 2, j, k + 6) +
              dhx[1] * _f_c(i - 1, j) * _g3_c(k + 6) * _s11(i - 1, j, k + 6) +
              dhx[3] * _f_c(i + 1, j) * _g3_c(k + 6) * _s11(i + 1, j, k + 6) +
              dhy[2] * _f(i, j) * _g3_c(k + 6) * _s12(i, j, k + 6) +
              dhy[0] * _f(i, j - 2) * _g3_c(k + 6) * _s12(i, j - 2, k + 6) +
              dhy[1] * _f(i, j - 1) * _g3_c(k + 6) * _s12(i, j - 1, k + 6) +
              dhy[3] * _f(i, j + 1) * _g3_c(k + 6) * _s12(i, j + 1, k + 6) +
              dhz[0] * _s13(i, j, k + 4) + dhz[1] * _s13(i, j, k + 5) +
              dhz[2] * _s13(i, j, k + 6) + dhz[3] * _s13(i, j, k + 7) -
              _f1_1(i, j) * (dhpz[0] * _g_c(k + 3) *
                                 (phx[2] * _s11(i, j, k + 3) +
                                  phx[0] * _s11(i - 2, j, k + 3) +
                                  phx[1] * _s11(i - 1, j, k + 3) +
                                  phx[3] * _s11(i + 1, j, k + 3)) +
                             dhpz[1] * _g_c(k + 4) *
                                 (phx[2] * _s11(i, j, k + 4) +
                                  phx[0] * _s11(i - 2, j, k + 4) +
                                  phx[1] * _s11(i - 1, j, k + 4) +
                                  phx[3] * _s11(i + 1, j, k + 4)) +
                             dhpz[2] * _g_c(k + 5) *
                                 (phx[2] * _s11(i, j, k + 5) +
                                  phx[0] * _s11(i - 2, j, k + 5) +
                                  phx[1] * _s11(i - 1, j, k + 5) +
                                  phx[3] * _s11(i + 1, j, k + 5)) +
                             dhpz[3] * _g_c(k + 6) *
                                 (phx[2] * _s11(i, j, k + 6) +
                                  phx[0] * _s11(i - 2, j, k + 6) +
                                  phx[1] * _s11(i - 1, j, k + 6) +
                                  phx[3] * _s11(i + 1, j, k + 6)) +
                             dhpz[4] * _g_c(k + 7) *
                                 (phx[2] * _s11(i, j, k + 7) +
                                  phx[0] * _s11(i - 2, j, k + 7) +
                                  phx[1] * _s11(i - 1, j, k + 7) +
                                  phx[3] * _s11(i + 1, j, k + 7)) +
                             dhpz[5] * _g_c(k + 8) *
                                 (phx[2] * _s11(i, j, k + 8) +
                                  phx[0] * _s11(i - 2, j, k + 8) +
                                  phx[1] * _s11(i - 1, j, k + 8) +
                                  phx[3] * _s11(i + 1, j, k + 8)) +
                             dhpz[6] * _g_c(k + 9) *
                                 (phx[2] * _s11(i, j, k + 9) +
                                  phx[0] * _s11(i - 2, j, k + 9) +
                                  phx[1] * _s11(i - 1, j, k + 9) +
                                  phx[3] * _s11(i + 1, j, k + 9))) -
              _f2_1(i, j) * (dhpz[0] * _g_c(k + 3) *
                                 (phy[2] * _s12(i, j, k + 3) +
                                  phy[0] * _s12(i, j - 2, k + 3) +
                                  phy[1] * _s12(i, j - 1, k + 3) +
                                  phy[3] * _s12(i, j + 1, k + 3)) +
                             dhpz[1] * _g_c(k + 4) *
                                 (phy[2] * _s12(i, j, k + 4) +
                                  phy[0] * _s12(i, j - 2, k + 4) +
                                  phy[1] * _s12(i, j - 1, k + 4) +
                                  phy[3] * _s12(i, j + 1, k + 4)) +
                             dhpz[2] * _g_c(k + 5) *
                                 (phy[2] * _s12(i, j, k + 5) +
                                  phy[0] * _s12(i, j - 2, k + 5) +
                                  phy[1] * _s12(i, j - 1, k + 5) +
                                  phy[3] * _s12(i, j + 1, k + 5)) +
                             dhpz[3] * _g_c(k + 6) *
                                 (phy[2] * _s12(i, j, k + 6) +
                                  phy[0] * _s12(i, j - 2, k + 6) +
                                  phy[1] * _s12(i, j - 1, k + 6) +
                                  phy[3] * _s12(i, j + 1, k + 6)) +
                             dhpz[4] * _g_c(k + 7) *
                                 (phy[2] * _s12(i, j, k + 7) +
                                  phy[0] * _s12(i, j - 2, k + 7) +
                                  phy[1] * _s12(i, j - 1, k + 7) +
                                  phy[3] * _s12(i, j + 1, k + 7)) +
                             dhpz[5] * _g_c(k + 8) *
                                 (phy[2] * _s12(i, j, k + 8) +
                                  phy[0] * _s12(i, j - 2, k + 8) +
                                  phy[1] * _s12(i, j - 1, k + 8) +
                                  phy[3] * _s12(i, j + 1, k + 8)) +
                             dhpz[6] * _g_c(k + 9) *
                                 (phy[2] * _s12(i, j, k + 9) +
                                  phy[0] * _s12(i, j - 2, k + 9) +
                                  phy[1] * _s12(i, j - 1, k + 9) +
                                  phy[3] * _s12(i, j + 1, k + 9))))) *
      f_dcrj;
  _u2(i, j, k + 6) =
      (a * _u2(i, j, k + 6) +
       Ai2 * (dhz[0] * _s23(i, j, k + 4) + dhz[1] * _s23(i, j, k + 5) +
              dhz[2] * _s23(i, j, k + 6) + dhz[3] * _s23(i, j, k + 7) +
              dx[1] * _f(i, j) * _g3_c(k + 6) * _s12(i, j, k + 6) +
              dx[0] * _f(i - 1, j) * _g3_c(k + 6) * _s12(i - 1, j, k + 6) +
              dx[2] * _f(i + 1, j) * _g3_c(k + 6) * _s12(i + 1, j, k + 6) +
              dx[3] * _f(i + 2, j) * _g3_c(k + 6) * _s12(i + 2, j, k + 6) +
              dy[1] * _f_c(i, j) * _g3_c(k + 6) * _s22(i, j, k + 6) +
              dy[0] * _f_c(i, j - 1) * _g3_c(k + 6) * _s22(i, j - 1, k + 6) +
              dy[2] * _f_c(i, j + 1) * _g3_c(k + 6) * _s22(i, j + 1, k + 6) +
              dy[3] * _f_c(i, j + 2) * _g3_c(k + 6) * _s22(i, j + 2, k + 6) -
              _f1_2(i, j) * (dhpz[0] * _g_c(k + 3) *
                                 (px[1] * _s12(i, j, k + 3) +
                                  px[0] * _s12(i - 1, j, k + 3) +
                                  px[2] * _s12(i + 1, j, k + 3) +
                                  px[3] * _s12(i + 2, j, k + 3)) +
                             dhpz[1] * _g_c(k + 4) *
                                 (px[1] * _s12(i, j, k + 4) +
                                  px[0] * _s12(i - 1, j, k + 4) +
                                  px[2] * _s12(i + 1, j, k + 4) +
                                  px[3] * _s12(i + 2, j, k + 4)) +
                             dhpz[2] * _g_c(k + 5) *
                                 (px[1] * _s12(i, j, k + 5) +
                                  px[0] * _s12(i - 1, j, k + 5) +
                                  px[2] * _s12(i + 1, j, k + 5) +
                                  px[3] * _s12(i + 2, j, k + 5)) +
                             dhpz[3] * _g_c(k + 6) *
                                 (px[1] * _s12(i, j, k + 6) +
                                  px[0] * _s12(i - 1, j, k + 6) +
                                  px[2] * _s12(i + 1, j, k + 6) +
                                  px[3] * _s12(i + 2, j, k + 6)) +
                             dhpz[4] * _g_c(k + 7) *
                                 (px[1] * _s12(i, j, k + 7) +
                                  px[0] * _s12(i - 1, j, k + 7) +
                                  px[2] * _s12(i + 1, j, k + 7) +
                                  px[3] * _s12(i + 2, j, k + 7)) +
                             dhpz[5] * _g_c(k + 8) *
                                 (px[1] * _s12(i, j, k + 8) +
                                  px[0] * _s12(i - 1, j, k + 8) +
                                  px[2] * _s12(i + 1, j, k + 8) +
                                  px[3] * _s12(i + 2, j, k + 8)) +
                             dhpz[6] * _g_c(k + 9) *
                                 (px[1] * _s12(i, j, k + 9) +
                                  px[0] * _s12(i - 1, j, k + 9) +
                                  px[2] * _s12(i + 1, j, k + 9) +
                                  px[3] * _s12(i + 2, j, k + 9))) -
              _f2_2(i, j) * (dhpz[0] * _g_c(k + 3) *
                                 (py[1] * _s22(i, j, k + 3) +
                                  py[0] * _s22(i, j - 1, k + 3) +
                                  py[2] * _s22(i, j + 1, k + 3) +
                                  py[3] * _s22(i, j + 2, k + 3)) +
                             dhpz[1] * _g_c(k + 4) *
                                 (py[1] * _s22(i, j, k + 4) +
                                  py[0] * _s22(i, j - 1, k + 4) +
                                  py[2] * _s22(i, j + 1, k + 4) +
                                  py[3] * _s22(i, j + 2, k + 4)) +
                             dhpz[2] * _g_c(k + 5) *
                                 (py[1] * _s22(i, j, k + 5) +
                                  py[0] * _s22(i, j - 1, k + 5) +
                                  py[2] * _s22(i, j + 1, k + 5) +
                                  py[3] * _s22(i, j + 2, k + 5)) +
                             dhpz[3] * _g_c(k + 6) *
                                 (py[1] * _s22(i, j, k + 6) +
                                  py[0] * _s22(i, j - 1, k + 6) +
                                  py[2] * _s22(i, j + 1, k + 6) +
                                  py[3] * _s22(i, j + 2, k + 6)) +
                             dhpz[4] * _g_c(k + 7) *
                                 (py[1] * _s22(i, j, k + 7) +
                                  py[0] * _s22(i, j - 1, k + 7) +
                                  py[2] * _s22(i, j + 1, k + 7) +
                                  py[3] * _s22(i, j + 2, k + 7)) +
                             dhpz[5] * _g_c(k + 8) *
                                 (py[1] * _s22(i, j, k + 8) +
                                  py[0] * _s22(i, j - 1, k + 8) +
                                  py[2] * _s22(i, j + 1, k + 8) +
                                  py[3] * _s22(i, j + 2, k + 8)) +
                             dhpz[6] * _g_c(k + 9) *
                                 (py[1] * _s22(i, j, k + 9) +
                                  py[0] * _s22(i, j - 1, k + 9) +
                                  py[2] * _s22(i, j + 1, k + 9) +
                                  py[3] * _s22(i, j + 2, k + 9))))) *
      f_dcrj;
  _u3(i, j, k + 6) =
      (a * _u3(i, j, k + 6) +
       Ai3 * (dhy[2] * _f_2(i, j) * _g3(k + 6) * _s23(i, j, k + 6) +
              dhy[0] * _f_2(i, j - 2) * _g3(k + 6) * _s23(i, j - 2, k + 6) +
              dhy[1] * _f_2(i, j - 1) * _g3(k + 6) * _s23(i, j - 1, k + 6) +
              dhy[3] * _f_2(i, j + 1) * _g3(k + 6) * _s23(i, j + 1, k + 6) +
              dx[1] * _f_1(i, j) * _g3(k + 6) * _s13(i, j, k + 6) +
              dx[0] * _f_1(i - 1, j) * _g3(k + 6) * _s13(i - 1, j, k + 6) +
              dx[2] * _f_1(i + 1, j) * _g3(k + 6) * _s13(i + 1, j, k + 6) +
              dx[3] * _f_1(i + 2, j) * _g3(k + 6) * _s13(i + 2, j, k + 6) +
              dz[0] * _s33(i, j, k + 5) + dz[1] * _s33(i, j, k + 6) +
              dz[2] * _s33(i, j, k + 7) + dz[3] * _s33(i, j, k + 8) -
              _f1_c(i, j) * (dphz[0] * _g(k + 3) *
                                 (px[1] * _s13(i, j, k + 3) +
                                  px[0] * _s13(i - 1, j, k + 3) +
                                  px[2] * _s13(i + 1, j, k + 3) +
                                  px[3] * _s13(i + 2, j, k + 3)) +
                             dphz[1] * _g(k + 4) *
                                 (px[1] * _s13(i, j, k + 4) +
                                  px[0] * _s13(i - 1, j, k + 4) +
                                  px[2] * _s13(i + 1, j, k + 4) +
                                  px[3] * _s13(i + 2, j, k + 4)) +
                             dphz[2] * _g(k + 5) *
                                 (px[1] * _s13(i, j, k + 5) +
                                  px[0] * _s13(i - 1, j, k + 5) +
                                  px[2] * _s13(i + 1, j, k + 5) +
                                  px[3] * _s13(i + 2, j, k + 5)) +
                             dphz[3] * _g(k + 6) *
                                 (px[1] * _s13(i, j, k + 6) +
                                  px[0] * _s13(i - 1, j, k + 6) +
                                  px[2] * _s13(i + 1, j, k + 6) +
                                  px[3] * _s13(i + 2, j, k + 6)) +
                             dphz[4] * _g(k + 7) *
                                 (px[1] * _s13(i, j, k + 7) +
                                  px[0] * _s13(i - 1, j, k + 7) +
                                  px[2] * _s13(i + 1, j, k + 7) +
                                  px[3] * _s13(i + 2, j, k + 7)) +
                             dphz[5] * _g(k + 8) *
                                 (px[1] * _s13(i, j, k + 8) +
                                  px[0] * _s13(i - 1, j, k + 8) +
                                  px[2] * _s13(i + 1, j, k + 8) +
                                  px[3] * _s13(i + 2, j, k + 8)) +
                             dphz[6] * _g(k + 9) *
                                 (px[1] * _s13(i, j, k + 9) +
                                  px[0] * _s13(i - 1, j, k + 9) +
                                  px[2] * _s13(i + 1, j, k + 9) +
                                  px[3] * _s13(i + 2, j, k + 9))) -
              _f2_c(i, j) * (dphz[0] * _g(k + 3) *
                                 (phy[2] * _s23(i, j, k + 3) +
                                  phy[0] * _s23(i, j - 2, k + 3) +
                                  phy[1] * _s23(i, j - 1, k + 3) +
                                  phy[3] * _s23(i, j + 1, k + 3)) +
                             dphz[1] * _g(k + 4) *
                                 (phy[2] * _s23(i, j, k + 4) +
                                  phy[0] * _s23(i, j - 2, k + 4) +
                                  phy[1] * _s23(i, j - 1, k + 4) +
                                  phy[3] * _s23(i, j + 1, k + 4)) +
                             dphz[2] * _g(k + 5) *
                                 (phy[2] * _s23(i, j, k + 5) +
                                  phy[0] * _s23(i, j - 2, k + 5) +
                                  phy[1] * _s23(i, j - 1, k + 5) +
                                  phy[3] * _s23(i, j + 1, k + 5)) +
                             dphz[3] * _g(k + 6) *
                                 (phy[2] * _s23(i, j, k + 6) +
                                  phy[0] * _s23(i, j - 2, k + 6) +
                                  phy[1] * _s23(i, j - 1, k + 6) +
                                  phy[3] * _s23(i, j + 1, k + 6)) +
                             dphz[4] * _g(k + 7) *
                                 (phy[2] * _s23(i, j, k + 7) +
                                  phy[0] * _s23(i, j - 2, k + 7) +
                                  phy[1] * _s23(i, j - 1, k + 7) +
                                  phy[3] * _s23(i, j + 1, k + 7)) +
                             dphz[5] * _g(k + 8) *
                                 (phy[2] * _s23(i, j, k + 8) +
                                  phy[0] * _s23(i, j - 2, k + 8) +
                                  phy[1] * _s23(i, j - 1, k + 8) +
                                  phy[3] * _s23(i, j + 1, k + 8)) +
                             dphz[6] * _g(k + 9) *
                                 (phy[2] * _s23(i, j, k + 9) +
                                  phy[0] * _s23(i, j - 2, k + 9) +
                                  phy[1] * _s23(i, j - 1, k + 9) +
                                  phy[3] * _s23(i, j + 1, k + 9))))) *
      f_dcrj;
#undef _rho
#undef _f_1
#undef _g3_c
#undef _f_2
#undef _f_c
#undef _g3
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _f
#undef _s13
#undef _u1
#undef _s11
#undef _f2_1
#undef _f1_1
#undef _s12
#undef _g_c
#undef _s23
#undef _f2_2
#undef _s22
#undef _f1_2
#undef _u2
#undef _g
#undef _s33
#undef _f2_c
#undef _f1_c
#undef _u3
}

__global__ void dtopo_vel_112(
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *rho,
    const float *s11, const float *s12, const float *s13, const float *s22,
    const float *s23, const float *s33, const float a, const float nu,
    const int nx, const int ny, const int nz, const int bi, const int bj,
    const int ei, const int ej) {
  const float phzr[6][8] = {
      {0.0000000000000000, 0.8338228784688313, 0.1775123316429260,
       0.1435067013076542, -0.1548419114194114, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.1813404047323969, 1.1246711188154426,
       -0.2933634518280757, -0.0126480717197637, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.1331142706282399, 0.7930714675884345,
       0.3131998767078508, 0.0268429263319546, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0969078556633046, -0.1539344946680898,
       0.4486491202844389, 0.6768738207821733, -0.0684963020618270,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0625000000000000, 0.5625000000000000, 0.5625000000000000,
       -0.0625000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, -0.0625000000000000, 0.5625000000000000,
       0.5625000000000000, -0.0625000000000000}};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float dhpzr[6][9] = {
      {-1.5373923010673118, -1.1059180740634813, -0.2134752473866528,
       -0.0352027995732726, -0.0075022330101095, -0.0027918394266035,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.8139439685257414, 0.1273679143938725, -1.1932750007455710,
       0.1475120181828087, 0.1125814499297686, -0.0081303502866204,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.1639182541610305, 0.3113839909089030, -0.0536007135209480,
       -0.3910958927076030, -0.0401741813821989, 0.0095685425408165,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0171478318814576, -0.0916600077207278, 0.7187220404622645,
       -0.1434031863528334, -0.5827389738506837, 0.0847863081664324,
       -0.0028540125859095, 0.0000000000000000, 0.0000000000000000},
      {-0.0579176640853654, 0.0022069616616207, 0.0108792602269819,
       0.6803612607837533, -0.0530169938441240, -0.6736586580761996,
       0.0937500000000000, -0.0026041666666667, 0.0000000000000000},
      {0.0020323834153791, 0.0002106933140862, -0.0013351454085978,
       -0.0938400881871787, 0.6816971139746001, -0.0002232904416222,
       -0.6796875000000000, 0.0937500000000000, -0.0026041666666667}};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhzr[6][8] = {
      {0.0000000000000000, -1.4511412472637157, -1.8534237417911470,
       0.3534237417911469, 0.0488587527362844, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.8577143189081458, -0.5731429567244373,
       -0.4268570432755628, 0.1422856810918542, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.1674548505882877, 0.4976354482351368,
       -0.4976354482351368, -0.1674548505882877, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.1027061113405124, 0.2624541326469860,
       0.8288742701021167, -1.0342864927831414, 0.0456642013745513,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0416666666666667, 1.1250000000000000, -1.1250000000000000,
       0.0416666666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, -0.0416666666666667, 1.1250000000000000,
       -1.1250000000000000, 0.0416666666666667}};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dphzr[6][9] = {
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -1.5886075042755421, -2.4835574634505861,
       0.0421173406787286, 0.4968761536590695, -0.0228264197210198,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.4428256655817484, -0.0574614517751294,
       -0.2022259589759502, -0.1944663890497050, 0.0113281342190362,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.3360140866060758, 1.2113298407847195,
       -0.3111668377093505, -0.6714462506479002, 0.1111440843153523,
       -0.0038467501367455, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0338560531369653, -0.0409943223643902,
       0.5284757132923059, 0.0115571196122084, -0.6162252315536446,
       0.0857115441015996, -0.0023808762250444, 0.0000000000000000},
      {0.0000000000000000, -0.0040378273193044, 0.0064139372778371,
       -0.0890062133451850, 0.6749219241340761, 0.0002498459192428,
       -0.6796875000000000, 0.0937500000000000, -0.0026041666666667}};
  const float dzr[6][7] = {
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-1.7779989465546753, -1.3337480247900155, -0.7775013168066564,
       0.3332503950419969, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.4410217341392059, 0.1730842484889890, -0.4487228323259926,
       -0.1653831503022022, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1798793213882701, 0.2757257254150788, 0.9597948548284453,
       -1.1171892610431817, 0.0615480021879277, 0.0000000000000000,
       0.0000000000000000},
      {-0.0153911381507088, -0.0568851455503591, 0.1998976464597171,
       0.8628231468598346, -1.0285385292191949, 0.0380940196007109,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0416666666666667, 1.1250000000000000, -1.1250000000000000,
       0.0416666666666667}};
  const int i = threadIdx.x + blockIdx.x * blockDim.x + bi;
  if (i >= nx)
    return;
  if (i >= ei)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= 6)
    return;
#define _rho(i, j, k)                                                          \
  rho[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
  float rho1 =
      phzr[k][7] *
          (phy[2] * _rho(i, j, nz - 8) + phy[0] * _rho(i, j - 2, nz - 8) +
           phy[1] * _rho(i, j - 1, nz - 8) + phy[3] * _rho(i, j + 1, nz - 8)) +
      phzr[k][6] *
          (phy[2] * _rho(i, j, nz - 7) + phy[0] * _rho(i, j - 2, nz - 7) +
           phy[1] * _rho(i, j - 1, nz - 7) + phy[3] * _rho(i, j + 1, nz - 7)) +
      phzr[k][5] *
          (phy[2] * _rho(i, j, nz - 6) + phy[0] * _rho(i, j - 2, nz - 6) +
           phy[1] * _rho(i, j - 1, nz - 6) + phy[3] * _rho(i, j + 1, nz - 6)) +
      phzr[k][4] *
          (phy[2] * _rho(i, j, nz - 5) + phy[0] * _rho(i, j - 2, nz - 5) +
           phy[1] * _rho(i, j - 1, nz - 5) + phy[3] * _rho(i, j + 1, nz - 5)) +
      phzr[k][3] *
          (phy[2] * _rho(i, j, nz - 4) + phy[0] * _rho(i, j - 2, nz - 4) +
           phy[1] * _rho(i, j - 1, nz - 4) + phy[3] * _rho(i, j + 1, nz - 4)) +
      phzr[k][2] *
          (phy[2] * _rho(i, j, nz - 3) + phy[0] * _rho(i, j - 2, nz - 3) +
           phy[1] * _rho(i, j - 1, nz - 3) + phy[3] * _rho(i, j + 1, nz - 3)) +
      phzr[k][1] *
          (phy[2] * _rho(i, j, nz - 2) + phy[0] * _rho(i, j - 2, nz - 2) +
           phy[1] * _rho(i, j - 1, nz - 2) + phy[3] * _rho(i, j + 1, nz - 2)) +
      phzr[k][0] *
          (phy[2] * _rho(i, j, nz - 1) + phy[0] * _rho(i, j - 2, nz - 1) +
           phy[1] * _rho(i, j - 1, nz - 1) + phy[3] * _rho(i, j + 1, nz - 1));
  float rho2 =
      phzr[k][7] *
          (phx[2] * _rho(i, j, nz - 8) + phx[0] * _rho(i - 2, j, nz - 8) +
           phx[1] * _rho(i - 1, j, nz - 8) + phx[3] * _rho(i + 1, j, nz - 8)) +
      phzr[k][6] *
          (phx[2] * _rho(i, j, nz - 7) + phx[0] * _rho(i - 2, j, nz - 7) +
           phx[1] * _rho(i - 1, j, nz - 7) + phx[3] * _rho(i + 1, j, nz - 7)) +
      phzr[k][5] *
          (phx[2] * _rho(i, j, nz - 6) + phx[0] * _rho(i - 2, j, nz - 6) +
           phx[1] * _rho(i - 1, j, nz - 6) + phx[3] * _rho(i + 1, j, nz - 6)) +
      phzr[k][4] *
          (phx[2] * _rho(i, j, nz - 5) + phx[0] * _rho(i - 2, j, nz - 5) +
           phx[1] * _rho(i - 1, j, nz - 5) + phx[3] * _rho(i + 1, j, nz - 5)) +
      phzr[k][3] *
          (phx[2] * _rho(i, j, nz - 4) + phx[0] * _rho(i - 2, j, nz - 4) +
           phx[1] * _rho(i - 1, j, nz - 4) + phx[3] * _rho(i + 1, j, nz - 4)) +
      phzr[k][2] *
          (phx[2] * _rho(i, j, nz - 3) + phx[0] * _rho(i - 2, j, nz - 3) +
           phx[1] * _rho(i - 1, j, nz - 3) + phx[3] * _rho(i + 1, j, nz - 3)) +
      phzr[k][1] *
          (phx[2] * _rho(i, j, nz - 2) + phx[0] * _rho(i - 2, j, nz - 2) +
           phx[1] * _rho(i - 1, j, nz - 2) + phx[3] * _rho(i + 1, j, nz - 2)) +
      phzr[k][0] *
          (phx[2] * _rho(i, j, nz - 1) + phx[0] * _rho(i - 2, j, nz - 1) +
           phx[1] * _rho(i - 1, j, nz - 1) + phx[3] * _rho(i + 1, j, nz - 1));
  float rho3 = phy[2] * (phx[2] * _rho(i, j, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j, nz - 1 - k)) +
               phy[0] * (phx[2] * _rho(i, j - 2, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j - 2, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j - 2, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j - 2, nz - 1 - k)) +
               phy[1] * (phx[2] * _rho(i, j - 1, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j - 1, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j - 1, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j - 1, nz - 1 - k)) +
               phy[3] * (phx[2] * _rho(i, j + 1, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j + 1, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j + 1, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j + 1, nz - 1 - k));
  float Ai1 = _f_1(i, j) * _g3_c(nz - 1 - k) * rho1;
  Ai1 = nu * 1.0 / Ai1;
  float Ai2 = _f_2(i, j) * _g3_c(nz - 1 - k) * rho2;
  Ai2 = nu * 1.0 / Ai2;
  float Ai3 = _f_c(i, j) * _g3(nz - 1 - k) * rho3;
  Ai3 = nu * 1.0 / Ai3;
  float f_dcrj = _dcrjx(i) * _dcrjy(j) * _dcrjz(nz - 1 - k);
  _u1(i, j, nz - 1 - k) =
      (a * _u1(i, j, nz - 1 - k) +
       Ai1 *
           (dhx[2] * _f_c(i, j) * _g3_c(nz - 1 - k) * _s11(i, j, nz - 1 - k) +
            dhx[0] * _f_c(i - 2, j) * _g3_c(nz - 1 - k) *
                _s11(i - 2, j, nz - 1 - k) +
            dhx[1] * _f_c(i - 1, j) * _g3_c(nz - 1 - k) *
                _s11(i - 1, j, nz - 1 - k) +
            dhx[3] * _f_c(i + 1, j) * _g3_c(nz - 1 - k) *
                _s11(i + 1, j, nz - 1 - k) +
            dhy[2] * _f(i, j) * _g3_c(nz - 1 - k) * _s12(i, j, nz - 1 - k) +
            dhy[0] * _f(i, j - 2) * _g3_c(nz - 1 - k) *
                _s12(i, j - 2, nz - 1 - k) +
            dhy[1] * _f(i, j - 1) * _g3_c(nz - 1 - k) *
                _s12(i, j - 1, nz - 1 - k) +
            dhy[3] * _f(i, j + 1) * _g3_c(nz - 1 - k) *
                _s12(i, j + 1, nz - 1 - k) +
            dhzr[k][7] * _s13(i, j, nz - 8) + dhzr[k][6] * _s13(i, j, nz - 7) +
            dhzr[k][5] * _s13(i, j, nz - 6) + dhzr[k][4] * _s13(i, j, nz - 5) +
            dhzr[k][3] * _s13(i, j, nz - 4) + dhzr[k][2] * _s13(i, j, nz - 3) +
            dhzr[k][1] * _s13(i, j, nz - 2) + dhzr[k][0] * _s13(i, j, nz - 1) -
            _f1_1(i, j) * (dhpzr[k][8] * _g_c(nz - 9) *
                               (phx[2] * _s11(i, j, nz - 9) +
                                phx[0] * _s11(i - 2, j, nz - 9) +
                                phx[1] * _s11(i - 1, j, nz - 9) +
                                phx[3] * _s11(i + 1, j, nz - 9)) +
                           dhpzr[k][7] * _g_c(nz - 8) *
                               (phx[2] * _s11(i, j, nz - 8) +
                                phx[0] * _s11(i - 2, j, nz - 8) +
                                phx[1] * _s11(i - 1, j, nz - 8) +
                                phx[3] * _s11(i + 1, j, nz - 8)) +
                           dhpzr[k][6] * _g_c(nz - 7) *
                               (phx[2] * _s11(i, j, nz - 7) +
                                phx[0] * _s11(i - 2, j, nz - 7) +
                                phx[1] * _s11(i - 1, j, nz - 7) +
                                phx[3] * _s11(i + 1, j, nz - 7)) +
                           dhpzr[k][5] * _g_c(nz - 6) *
                               (phx[2] * _s11(i, j, nz - 6) +
                                phx[0] * _s11(i - 2, j, nz - 6) +
                                phx[1] * _s11(i - 1, j, nz - 6) +
                                phx[3] * _s11(i + 1, j, nz - 6)) +
                           dhpzr[k][4] * _g_c(nz - 5) *
                               (phx[2] * _s11(i, j, nz - 5) +
                                phx[0] * _s11(i - 2, j, nz - 5) +
                                phx[1] * _s11(i - 1, j, nz - 5) +
                                phx[3] * _s11(i + 1, j, nz - 5)) +
                           dhpzr[k][3] * _g_c(nz - 4) *
                               (phx[2] * _s11(i, j, nz - 4) +
                                phx[0] * _s11(i - 2, j, nz - 4) +
                                phx[1] * _s11(i - 1, j, nz - 4) +
                                phx[3] * _s11(i + 1, j, nz - 4)) +
                           dhpzr[k][2] * _g_c(nz - 3) *
                               (phx[2] * _s11(i, j, nz - 3) +
                                phx[0] * _s11(i - 2, j, nz - 3) +
                                phx[1] * _s11(i - 1, j, nz - 3) +
                                phx[3] * _s11(i + 1, j, nz - 3)) +
                           dhpzr[k][1] * _g_c(nz - 2) *
                               (phx[2] * _s11(i, j, nz - 2) +
                                phx[0] * _s11(i - 2, j, nz - 2) +
                                phx[1] * _s11(i - 1, j, nz - 2) +
                                phx[3] * _s11(i + 1, j, nz - 2)) +
                           dhpzr[k][0] * _g_c(nz - 1) *
                               (phx[2] * _s11(i, j, nz - 1) +
                                phx[0] * _s11(i - 2, j, nz - 1) +
                                phx[1] * _s11(i - 1, j, nz - 1) +
                                phx[3] * _s11(i + 1, j, nz - 1))) -
            _f2_1(i, j) * (dhpzr[k][8] * _g_c(nz - 9) *
                               (phy[2] * _s12(i, j, nz - 9) +
                                phy[0] * _s12(i, j - 2, nz - 9) +
                                phy[1] * _s12(i, j - 1, nz - 9) +
                                phy[3] * _s12(i, j + 1, nz - 9)) +
                           dhpzr[k][7] * _g_c(nz - 8) *
                               (phy[2] * _s12(i, j, nz - 8) +
                                phy[0] * _s12(i, j - 2, nz - 8) +
                                phy[1] * _s12(i, j - 1, nz - 8) +
                                phy[3] * _s12(i, j + 1, nz - 8)) +
                           dhpzr[k][6] * _g_c(nz - 7) *
                               (phy[2] * _s12(i, j, nz - 7) +
                                phy[0] * _s12(i, j - 2, nz - 7) +
                                phy[1] * _s12(i, j - 1, nz - 7) +
                                phy[3] * _s12(i, j + 1, nz - 7)) +
                           dhpzr[k][5] * _g_c(nz - 6) *
                               (phy[2] * _s12(i, j, nz - 6) +
                                phy[0] * _s12(i, j - 2, nz - 6) +
                                phy[1] * _s12(i, j - 1, nz - 6) +
                                phy[3] * _s12(i, j + 1, nz - 6)) +
                           dhpzr[k][4] * _g_c(nz - 5) *
                               (phy[2] * _s12(i, j, nz - 5) +
                                phy[0] * _s12(i, j - 2, nz - 5) +
                                phy[1] * _s12(i, j - 1, nz - 5) +
                                phy[3] * _s12(i, j + 1, nz - 5)) +
                           dhpzr[k][3] * _g_c(nz - 4) *
                               (phy[2] * _s12(i, j, nz - 4) +
                                phy[0] * _s12(i, j - 2, nz - 4) +
                                phy[1] * _s12(i, j - 1, nz - 4) +
                                phy[3] * _s12(i, j + 1, nz - 4)) +
                           dhpzr[k][2] * _g_c(nz - 3) *
                               (phy[2] * _s12(i, j, nz - 3) +
                                phy[0] * _s12(i, j - 2, nz - 3) +
                                phy[1] * _s12(i, j - 1, nz - 3) +
                                phy[3] * _s12(i, j + 1, nz - 3)) +
                           dhpzr[k][1] * _g_c(nz - 2) *
                               (phy[2] * _s12(i, j, nz - 2) +
                                phy[0] * _s12(i, j - 2, nz - 2) +
                                phy[1] * _s12(i, j - 1, nz - 2) +
                                phy[3] * _s12(i, j + 1, nz - 2)) +
                           dhpzr[k][0] * _g_c(nz - 1) *
                               (phy[2] * _s12(i, j, nz - 1) +
                                phy[0] * _s12(i, j - 2, nz - 1) +
                                phy[1] * _s12(i, j - 1, nz - 1) +
                                phy[3] * _s12(i, j + 1, nz - 1))))) *
      f_dcrj;
  _u2(i, j, nz - 1 - k) =
      (a * _u2(i, j, nz - 1 - k) +
       Ai2 *
           (dhzr[k][7] * _s23(i, j, nz - 8) + dhzr[k][6] * _s23(i, j, nz - 7) +
            dhzr[k][5] * _s23(i, j, nz - 6) + dhzr[k][4] * _s23(i, j, nz - 5) +
            dhzr[k][3] * _s23(i, j, nz - 4) + dhzr[k][2] * _s23(i, j, nz - 3) +
            dhzr[k][1] * _s23(i, j, nz - 2) + dhzr[k][0] * _s23(i, j, nz - 1) +
            dx[1] * _f(i, j) * _g3_c(nz - 1 - k) * _s12(i, j, nz - 1 - k) +
            dx[0] * _f(i - 1, j) * _g3_c(nz - 1 - k) *
                _s12(i - 1, j, nz - 1 - k) +
            dx[2] * _f(i + 1, j) * _g3_c(nz - 1 - k) *
                _s12(i + 1, j, nz - 1 - k) +
            dx[3] * _f(i + 2, j) * _g3_c(nz - 1 - k) *
                _s12(i + 2, j, nz - 1 - k) +
            dy[1] * _f_c(i, j) * _g3_c(nz - 1 - k) * _s22(i, j, nz - 1 - k) +
            dy[0] * _f_c(i, j - 1) * _g3_c(nz - 1 - k) *
                _s22(i, j - 1, nz - 1 - k) +
            dy[2] * _f_c(i, j + 1) * _g3_c(nz - 1 - k) *
                _s22(i, j + 1, nz - 1 - k) +
            dy[3] * _f_c(i, j + 2) * _g3_c(nz - 1 - k) *
                _s22(i, j + 2, nz - 1 - k) -
            _f1_2(i, j) * (dhpzr[k][8] * _g_c(nz - 9) *
                               (px[1] * _s12(i, j, nz - 9) +
                                px[0] * _s12(i - 1, j, nz - 9) +
                                px[2] * _s12(i + 1, j, nz - 9) +
                                px[3] * _s12(i + 2, j, nz - 9)) +
                           dhpzr[k][7] * _g_c(nz - 8) *
                               (px[1] * _s12(i, j, nz - 8) +
                                px[0] * _s12(i - 1, j, nz - 8) +
                                px[2] * _s12(i + 1, j, nz - 8) +
                                px[3] * _s12(i + 2, j, nz - 8)) +
                           dhpzr[k][6] * _g_c(nz - 7) *
                               (px[1] * _s12(i, j, nz - 7) +
                                px[0] * _s12(i - 1, j, nz - 7) +
                                px[2] * _s12(i + 1, j, nz - 7) +
                                px[3] * _s12(i + 2, j, nz - 7)) +
                           dhpzr[k][5] * _g_c(nz - 6) *
                               (px[1] * _s12(i, j, nz - 6) +
                                px[0] * _s12(i - 1, j, nz - 6) +
                                px[2] * _s12(i + 1, j, nz - 6) +
                                px[3] * _s12(i + 2, j, nz - 6)) +
                           dhpzr[k][4] * _g_c(nz - 5) *
                               (px[1] * _s12(i, j, nz - 5) +
                                px[0] * _s12(i - 1, j, nz - 5) +
                                px[2] * _s12(i + 1, j, nz - 5) +
                                px[3] * _s12(i + 2, j, nz - 5)) +
                           dhpzr[k][3] * _g_c(nz - 4) *
                               (px[1] * _s12(i, j, nz - 4) +
                                px[0] * _s12(i - 1, j, nz - 4) +
                                px[2] * _s12(i + 1, j, nz - 4) +
                                px[3] * _s12(i + 2, j, nz - 4)) +
                           dhpzr[k][2] * _g_c(nz - 3) *
                               (px[1] * _s12(i, j, nz - 3) +
                                px[0] * _s12(i - 1, j, nz - 3) +
                                px[2] * _s12(i + 1, j, nz - 3) +
                                px[3] * _s12(i + 2, j, nz - 3)) +
                           dhpzr[k][1] * _g_c(nz - 2) *
                               (px[1] * _s12(i, j, nz - 2) +
                                px[0] * _s12(i - 1, j, nz - 2) +
                                px[2] * _s12(i + 1, j, nz - 2) +
                                px[3] * _s12(i + 2, j, nz - 2)) +
                           dhpzr[k][0] * _g_c(nz - 1) *
                               (px[1] * _s12(i, j, nz - 1) +
                                px[0] * _s12(i - 1, j, nz - 1) +
                                px[2] * _s12(i + 1, j, nz - 1) +
                                px[3] * _s12(i + 2, j, nz - 1))) -
            _f2_2(i, j) * (dhpzr[k][8] * _g_c(nz - 9) *
                               (py[1] * _s22(i, j, nz - 9) +
                                py[0] * _s22(i, j - 1, nz - 9) +
                                py[2] * _s22(i, j + 1, nz - 9) +
                                py[3] * _s22(i, j + 2, nz - 9)) +
                           dhpzr[k][7] * _g_c(nz - 8) *
                               (py[1] * _s22(i, j, nz - 8) +
                                py[0] * _s22(i, j - 1, nz - 8) +
                                py[2] * _s22(i, j + 1, nz - 8) +
                                py[3] * _s22(i, j + 2, nz - 8)) +
                           dhpzr[k][6] * _g_c(nz - 7) *
                               (py[1] * _s22(i, j, nz - 7) +
                                py[0] * _s22(i, j - 1, nz - 7) +
                                py[2] * _s22(i, j + 1, nz - 7) +
                                py[3] * _s22(i, j + 2, nz - 7)) +
                           dhpzr[k][5] * _g_c(nz - 6) *
                               (py[1] * _s22(i, j, nz - 6) +
                                py[0] * _s22(i, j - 1, nz - 6) +
                                py[2] * _s22(i, j + 1, nz - 6) +
                                py[3] * _s22(i, j + 2, nz - 6)) +
                           dhpzr[k][4] * _g_c(nz - 5) *
                               (py[1] * _s22(i, j, nz - 5) +
                                py[0] * _s22(i, j - 1, nz - 5) +
                                py[2] * _s22(i, j + 1, nz - 5) +
                                py[3] * _s22(i, j + 2, nz - 5)) +
                           dhpzr[k][3] * _g_c(nz - 4) *
                               (py[1] * _s22(i, j, nz - 4) +
                                py[0] * _s22(i, j - 1, nz - 4) +
                                py[2] * _s22(i, j + 1, nz - 4) +
                                py[3] * _s22(i, j + 2, nz - 4)) +
                           dhpzr[k][2] * _g_c(nz - 3) *
                               (py[1] * _s22(i, j, nz - 3) +
                                py[0] * _s22(i, j - 1, nz - 3) +
                                py[2] * _s22(i, j + 1, nz - 3) +
                                py[3] * _s22(i, j + 2, nz - 3)) +
                           dhpzr[k][1] * _g_c(nz - 2) *
                               (py[1] * _s22(i, j, nz - 2) +
                                py[0] * _s22(i, j - 1, nz - 2) +
                                py[2] * _s22(i, j + 1, nz - 2) +
                                py[3] * _s22(i, j + 2, nz - 2)) +
                           dhpzr[k][0] * _g_c(nz - 1) *
                               (py[1] * _s22(i, j, nz - 1) +
                                py[0] * _s22(i, j - 1, nz - 1) +
                                py[2] * _s22(i, j + 1, nz - 1) +
                                py[3] * _s22(i, j + 2, nz - 1))))) *
      f_dcrj;
  _u3(i, j, nz - 1 - k) =
      (a * _u3(i, j, nz - 1 - k) +
       Ai3 * (dhy[2] * _f_2(i, j) * _g3(nz - 1 - k) * _s23(i, j, nz - 1 - k) +
              dhy[0] * _f_2(i, j - 2) * _g3(nz - 1 - k) *
                  _s23(i, j - 2, nz - 1 - k) +
              dhy[1] * _f_2(i, j - 1) * _g3(nz - 1 - k) *
                  _s23(i, j - 1, nz - 1 - k) +
              dhy[3] * _f_2(i, j + 1) * _g3(nz - 1 - k) *
                  _s23(i, j + 1, nz - 1 - k) +
              dx[1] * _f_1(i, j) * _g3(nz - 1 - k) * _s13(i, j, nz - 1 - k) +
              dx[0] * _f_1(i - 1, j) * _g3(nz - 1 - k) *
                  _s13(i - 1, j, nz - 1 - k) +
              dx[2] * _f_1(i + 1, j) * _g3(nz - 1 - k) *
                  _s13(i + 1, j, nz - 1 - k) +
              dx[3] * _f_1(i + 2, j) * _g3(nz - 1 - k) *
                  _s13(i + 2, j, nz - 1 - k) +
              dzr[k][6] * _s33(i, j, nz - 7) + dzr[k][5] * _s33(i, j, nz - 6) +
              dzr[k][4] * _s33(i, j, nz - 5) + dzr[k][3] * _s33(i, j, nz - 4) +
              dzr[k][2] * _s33(i, j, nz - 3) + dzr[k][1] * _s33(i, j, nz - 2) +
              dzr[k][0] * _s33(i, j, nz - 1) -
              _f1_c(i, j) * (dphzr[k][8] * _g(nz - 9) *
                                 (px[1] * _s13(i, j, nz - 9) +
                                  px[0] * _s13(i - 1, j, nz - 9) +
                                  px[2] * _s13(i + 1, j, nz - 9) +
                                  px[3] * _s13(i + 2, j, nz - 9)) +
                             dphzr[k][7] * _g(nz - 8) *
                                 (px[1] * _s13(i, j, nz - 8) +
                                  px[0] * _s13(i - 1, j, nz - 8) +
                                  px[2] * _s13(i + 1, j, nz - 8) +
                                  px[3] * _s13(i + 2, j, nz - 8)) +
                             dphzr[k][6] * _g(nz - 7) *
                                 (px[1] * _s13(i, j, nz - 7) +
                                  px[0] * _s13(i - 1, j, nz - 7) +
                                  px[2] * _s13(i + 1, j, nz - 7) +
                                  px[3] * _s13(i + 2, j, nz - 7)) +
                             dphzr[k][5] * _g(nz - 6) *
                                 (px[1] * _s13(i, j, nz - 6) +
                                  px[0] * _s13(i - 1, j, nz - 6) +
                                  px[2] * _s13(i + 1, j, nz - 6) +
                                  px[3] * _s13(i + 2, j, nz - 6)) +
                             dphzr[k][4] * _g(nz - 5) *
                                 (px[1] * _s13(i, j, nz - 5) +
                                  px[0] * _s13(i - 1, j, nz - 5) +
                                  px[2] * _s13(i + 1, j, nz - 5) +
                                  px[3] * _s13(i + 2, j, nz - 5)) +
                             dphzr[k][3] * _g(nz - 4) *
                                 (px[1] * _s13(i, j, nz - 4) +
                                  px[0] * _s13(i - 1, j, nz - 4) +
                                  px[2] * _s13(i + 1, j, nz - 4) +
                                  px[3] * _s13(i + 2, j, nz - 4)) +
                             dphzr[k][2] * _g(nz - 3) *
                                 (px[1] * _s13(i, j, nz - 3) +
                                  px[0] * _s13(i - 1, j, nz - 3) +
                                  px[2] * _s13(i + 1, j, nz - 3) +
                                  px[3] * _s13(i + 2, j, nz - 3)) +
                             dphzr[k][1] * _g(nz - 2) *
                                 (px[1] * _s13(i, j, nz - 2) +
                                  px[0] * _s13(i - 1, j, nz - 2) +
                                  px[2] * _s13(i + 1, j, nz - 2) +
                                  px[3] * _s13(i + 2, j, nz - 2)) +
                             dphzr[k][0] * _g(nz - 1) *
                                 (px[1] * _s13(i, j, nz - 1) +
                                  px[0] * _s13(i - 1, j, nz - 1) +
                                  px[2] * _s13(i + 1, j, nz - 1) +
                                  px[3] * _s13(i + 2, j, nz - 1))) -
              _f2_c(i, j) * (dphzr[k][8] * _g(nz - 9) *
                                 (phy[2] * _s23(i, j, nz - 9) +
                                  phy[0] * _s23(i, j - 2, nz - 9) +
                                  phy[1] * _s23(i, j - 1, nz - 9) +
                                  phy[3] * _s23(i, j + 1, nz - 9)) +
                             dphzr[k][7] * _g(nz - 8) *
                                 (phy[2] * _s23(i, j, nz - 8) +
                                  phy[0] * _s23(i, j - 2, nz - 8) +
                                  phy[1] * _s23(i, j - 1, nz - 8) +
                                  phy[3] * _s23(i, j + 1, nz - 8)) +
                             dphzr[k][6] * _g(nz - 7) *
                                 (phy[2] * _s23(i, j, nz - 7) +
                                  phy[0] * _s23(i, j - 2, nz - 7) +
                                  phy[1] * _s23(i, j - 1, nz - 7) +
                                  phy[3] * _s23(i, j + 1, nz - 7)) +
                             dphzr[k][5] * _g(nz - 6) *
                                 (phy[2] * _s23(i, j, nz - 6) +
                                  phy[0] * _s23(i, j - 2, nz - 6) +
                                  phy[1] * _s23(i, j - 1, nz - 6) +
                                  phy[3] * _s23(i, j + 1, nz - 6)) +
                             dphzr[k][4] * _g(nz - 5) *
                                 (phy[2] * _s23(i, j, nz - 5) +
                                  phy[0] * _s23(i, j - 2, nz - 5) +
                                  phy[1] * _s23(i, j - 1, nz - 5) +
                                  phy[3] * _s23(i, j + 1, nz - 5)) +
                             dphzr[k][3] * _g(nz - 4) *
                                 (phy[2] * _s23(i, j, nz - 4) +
                                  phy[0] * _s23(i, j - 2, nz - 4) +
                                  phy[1] * _s23(i, j - 1, nz - 4) +
                                  phy[3] * _s23(i, j + 1, nz - 4)) +
                             dphzr[k][2] * _g(nz - 3) *
                                 (phy[2] * _s23(i, j, nz - 3) +
                                  phy[0] * _s23(i, j - 2, nz - 3) +
                                  phy[1] * _s23(i, j - 1, nz - 3) +
                                  phy[3] * _s23(i, j + 1, nz - 3)) +
                             dphzr[k][1] * _g(nz - 2) *
                                 (phy[2] * _s23(i, j, nz - 2) +
                                  phy[0] * _s23(i, j - 2, nz - 2) +
                                  phy[1] * _s23(i, j - 1, nz - 2) +
                                  phy[3] * _s23(i, j + 1, nz - 2)) +
                             dphzr[k][0] * _g(nz - 1) *
                                 (phy[2] * _s23(i, j, nz - 1) +
                                  phy[0] * _s23(i, j - 2, nz - 1) +
                                  phy[1] * _s23(i, j - 1, nz - 1) +
                                  phy[3] * _s23(i, j + 1, nz - 1))))) *
      f_dcrj;
#undef _rho
#undef _f_1
#undef _g3_c
#undef _f_2
#undef _f_c
#undef _g3
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _f
#undef _s13
#undef _u1
#undef _s11
#undef _f2_1
#undef _f1_1
#undef _s12
#undef _g_c
#undef _s23
#undef _f2_2
#undef _s22
#undef _f1_2
#undef _u2
#undef _g
#undef _s33
#undef _f2_c
#undef _f1_c
#undef _u3
}

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
    const int rj0) {
  const float phzl[6][7] = {
      {0.8338228784688313, 0.1775123316429260, 0.1435067013076542,
       -0.1548419114194114, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.1813404047323969, 1.1246711188154426, -0.2933634518280757,
       -0.0126480717197637, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1331142706282399, 0.7930714675884345, 0.3131998767078508,
       0.0268429263319546, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.0969078556633046, -0.1539344946680898, 0.4486491202844389,
       0.6768738207821733, -0.0684963020618270, 0.0000000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, -0.0625000000000000,
       0.5625000000000000, 0.5625000000000000, -0.0625000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0625000000000000, 0.5625000000000000, 0.5625000000000000,
       -0.0625000000000000}};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float dhpzl[6][9] = {
      {-1.4276800979942257, 0.2875185051606178, 2.0072491465276454,
       -0.8773816261307504, 0.0075022330101095, 0.0027918394266035,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.8139439685257414, -0.1273679143938725, 1.1932750007455708,
       -0.1475120181828087, -0.1125814499297686, 0.0081303502866204,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.1639182541610305, -0.3113839909089031, 0.0536007135209480,
       0.3910958927076031, 0.0401741813821989, -0.0095685425408165,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.0171478318814576, 0.0916600077207278, -0.7187220404622644,
       0.1434031863528334, 0.5827389738506837, -0.0847863081664324,
       0.0028540125859095, 0.0000000000000000, 0.0000000000000000},
      {0.0579176640853654, -0.0022069616616207, -0.0108792602269819,
       -0.6803612607837533, 0.0530169938441241, 0.6736586580761996,
       -0.0937500000000000, 0.0026041666666667, 0.0000000000000000},
      {-0.0020323834153791, -0.0002106933140862, 0.0013351454085978,
       0.0938400881871787, -0.6816971139746001, 0.0002232904416222,
       0.6796875000000000, -0.0937500000000000, 0.0026041666666667}};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhzl[6][7] = {
      {-1.4511412472637157, 1.8534237417911470, -0.3534237417911469,
       -0.0488587527362844, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.8577143189081458, 0.5731429567244373, 0.4268570432755628,
       -0.1422856810918542, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1674548505882877, -0.4976354482351368, 0.4976354482351368,
       0.1674548505882877, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.1027061113405124, -0.2624541326469860, -0.8288742701021167,
       1.0342864927831414, -0.0456642013745513, 0.0000000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0416666666666667,
       -1.1250000000000000, 1.1250000000000000, -0.0416666666666667,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0416666666666667, -1.1250000000000000, 1.1250000000000000,
       -0.0416666666666667}};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dphzl[6][9] = {
      {-1.3764648947859957, 1.8523239861274134, -0.5524268681758195,
       0.0537413571133823, 0.0228264197210198, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.4428256655817484, 0.0574614517751293, 0.2022259589759502,
       0.1944663890497050, -0.0113281342190362, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.3360140866060757, -1.2113298407847195, 0.3111668377093505,
       0.6714462506479003, -0.1111440843153523, 0.0038467501367455,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.0338560531369653, 0.0409943223643901, -0.5284757132923059,
       -0.0115571196122084, 0.6162252315536445, -0.0857115441015996,
       0.0023808762250444, 0.0000000000000000, 0.0000000000000000},
      {0.0040378273193044, -0.0064139372778371, 0.0890062133451850,
       -0.6749219241340761, -0.0002498459192428, 0.6796875000000000,
       -0.0937500000000000, 0.0026041666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, -0.0026041666666667,
       0.0937500000000000, -0.6796875000000000, 0.0000000000000000,
       0.6796875000000000, -0.0937500000000000, 0.0026041666666667}};
  const float dzl[6][8] = {
      {-1.7779989465546748, 1.3337480247900155, 0.7775013168066564,
       -0.3332503950419969, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {-0.4410217341392059, -0.1730842484889890, 0.4487228323259926,
       0.1653831503022022, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.1798793213882701, -0.2757257254150788, -0.9597948548284453,
       1.1171892610431817, -0.0615480021879277, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0153911381507088, 0.0568851455503591, -0.1998976464597171,
       -0.8628231468598346, 1.0285385292191949, -0.0380940196007109,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0416666666666667, -1.1250000000000000, 1.1250000000000000,
       -0.0416666666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0416666666666667, -1.1250000000000000,
       1.1250000000000000, -0.0416666666666667}};
  const int i = threadIdx.x + blockIdx.x * blockDim.x;
  if (i >= nx)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= 6)
    return;
#define _rho(i, j, k)                                                          \
  rho[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _buf_u1(i, j, k)                                                       \
  buf_u1[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
#define _buf_u2(i, j, k)                                                       \
  buf_u2[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
#define _buf_u3(i, j, k)                                                       \
  buf_u3[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
  float rho1 =
      phzl[k][0] *
          (phy[2] * _rho(i, j + rj0, 0) + phy[0] * _rho(i, j + rj0 - 2, 0) +
           phy[1] * _rho(i, j + rj0 - 1, 0) +
           phy[3] * _rho(i, j + rj0 + 1, 0)) +
      phzl[k][1] *
          (phy[2] * _rho(i, j + rj0, 1) + phy[0] * _rho(i, j + rj0 - 2, 1) +
           phy[1] * _rho(i, j + rj0 - 1, 1) +
           phy[3] * _rho(i, j + rj0 + 1, 1)) +
      phzl[k][2] *
          (phy[2] * _rho(i, j + rj0, 2) + phy[0] * _rho(i, j + rj0 - 2, 2) +
           phy[1] * _rho(i, j + rj0 - 1, 2) +
           phy[3] * _rho(i, j + rj0 + 1, 2)) +
      phzl[k][3] *
          (phy[2] * _rho(i, j + rj0, 3) + phy[0] * _rho(i, j + rj0 - 2, 3) +
           phy[1] * _rho(i, j + rj0 - 1, 3) +
           phy[3] * _rho(i, j + rj0 + 1, 3)) +
      phzl[k][4] *
          (phy[2] * _rho(i, j + rj0, 4) + phy[0] * _rho(i, j + rj0 - 2, 4) +
           phy[1] * _rho(i, j + rj0 - 1, 4) +
           phy[3] * _rho(i, j + rj0 + 1, 4)) +
      phzl[k][5] *
          (phy[2] * _rho(i, j + rj0, 5) + phy[0] * _rho(i, j + rj0 - 2, 5) +
           phy[1] * _rho(i, j + rj0 - 1, 5) +
           phy[3] * _rho(i, j + rj0 + 1, 5)) +
      phzl[k][6] *
          (phy[2] * _rho(i, j + rj0, 6) + phy[0] * _rho(i, j + rj0 - 2, 6) +
           phy[1] * _rho(i, j + rj0 - 1, 6) + phy[3] * _rho(i, j + rj0 + 1, 6));
  float rho2 =
      phzl[k][0] *
          (phx[2] * _rho(i, j + rj0, 0) + phx[0] * _rho(i - 2, j + rj0, 0) +
           phx[1] * _rho(i - 1, j + rj0, 0) +
           phx[3] * _rho(i + 1, j + rj0, 0)) +
      phzl[k][1] *
          (phx[2] * _rho(i, j + rj0, 1) + phx[0] * _rho(i - 2, j + rj0, 1) +
           phx[1] * _rho(i - 1, j + rj0, 1) +
           phx[3] * _rho(i + 1, j + rj0, 1)) +
      phzl[k][2] *
          (phx[2] * _rho(i, j + rj0, 2) + phx[0] * _rho(i - 2, j + rj0, 2) +
           phx[1] * _rho(i - 1, j + rj0, 2) +
           phx[3] * _rho(i + 1, j + rj0, 2)) +
      phzl[k][3] *
          (phx[2] * _rho(i, j + rj0, 3) + phx[0] * _rho(i - 2, j + rj0, 3) +
           phx[1] * _rho(i - 1, j + rj0, 3) +
           phx[3] * _rho(i + 1, j + rj0, 3)) +
      phzl[k][4] *
          (phx[2] * _rho(i, j + rj0, 4) + phx[0] * _rho(i - 2, j + rj0, 4) +
           phx[1] * _rho(i - 1, j + rj0, 4) +
           phx[3] * _rho(i + 1, j + rj0, 4)) +
      phzl[k][5] *
          (phx[2] * _rho(i, j + rj0, 5) + phx[0] * _rho(i - 2, j + rj0, 5) +
           phx[1] * _rho(i - 1, j + rj0, 5) +
           phx[3] * _rho(i + 1, j + rj0, 5)) +
      phzl[k][6] *
          (phx[2] * _rho(i, j + rj0, 6) + phx[0] * _rho(i - 2, j + rj0, 6) +
           phx[1] * _rho(i - 1, j + rj0, 6) + phx[3] * _rho(i + 1, j + rj0, 6));
  float rho3 = phy[2] * (phx[2] * _rho(i, j + rj0, k) +
                         phx[0] * _rho(i - 2, j + rj0, k) +
                         phx[1] * _rho(i - 1, j + rj0, k) +
                         phx[3] * _rho(i + 1, j + rj0, k)) +
               phy[0] * (phx[2] * _rho(i, j + rj0 - 2, k) +
                         phx[0] * _rho(i - 2, j + rj0 - 2, k) +
                         phx[1] * _rho(i - 1, j + rj0 - 2, k) +
                         phx[3] * _rho(i + 1, j + rj0 - 2, k)) +
               phy[1] * (phx[2] * _rho(i, j + rj0 - 1, k) +
                         phx[0] * _rho(i - 2, j + rj0 - 1, k) +
                         phx[1] * _rho(i - 1, j + rj0 - 1, k) +
                         phx[3] * _rho(i + 1, j + rj0 - 1, k)) +
               phy[3] * (phx[2] * _rho(i, j + rj0 + 1, k) +
                         phx[0] * _rho(i - 2, j + rj0 + 1, k) +
                         phx[1] * _rho(i - 1, j + rj0 + 1, k) +
                         phx[3] * _rho(i + 1, j + rj0 + 1, k));
  float Ai1 = _f_1(i, j + rj0) * _g3_c(k) * rho1;
  Ai1 = nu * 1.0 / Ai1;
  float Ai2 = _f_2(i, j + rj0) * _g3_c(k) * rho2;
  Ai2 = nu * 1.0 / Ai2;
  float Ai3 = _f_c(i, j + rj0) * _g3(k) * rho3;
  Ai3 = nu * 1.0 / Ai3;
  float f_dcrj = _dcrjx(i) * _dcrjy(j + rj0) * _dcrjz(k);
  _buf_u1(i, j, k) =
      (a * _u1(i, j + rj0, k) +
       Ai1 *
           (dhx[2] * _f_c(i, j + rj0) * _g3_c(k) * _s11(i, j + rj0, k) +
            dhx[0] * _f_c(i - 2, j + rj0) * _g3_c(k) * _s11(i - 2, j + rj0, k) +
            dhx[1] * _f_c(i - 1, j + rj0) * _g3_c(k) * _s11(i - 1, j + rj0, k) +
            dhx[3] * _f_c(i + 1, j + rj0) * _g3_c(k) * _s11(i + 1, j + rj0, k) +
            dhy[2] * _f(i, j + rj0) * _g3_c(k) * _s12(i, j + rj0, k) +
            dhy[0] * _f(i, j + rj0 - 2) * _g3_c(k) * _s12(i, j + rj0 - 2, k) +
            dhy[1] * _f(i, j + rj0 - 1) * _g3_c(k) * _s12(i, j + rj0 - 1, k) +
            dhy[3] * _f(i, j + rj0 + 1) * _g3_c(k) * _s12(i, j + rj0 + 1, k) +
            dhzl[k][0] * _s13(i, j + rj0, 0) +
            dhzl[k][1] * _s13(i, j + rj0, 1) +
            dhzl[k][2] * _s13(i, j + rj0, 2) +
            dhzl[k][3] * _s13(i, j + rj0, 3) +
            dhzl[k][4] * _s13(i, j + rj0, 4) +
            dhzl[k][5] * _s13(i, j + rj0, 5) +
            dhzl[k][6] * _s13(i, j + rj0, 6) -
            _f1_1(i, j + rj0) * (dhpzl[k][0] * _g_c(0) *
                                     (phx[2] * _s11(i, j + rj0, 0) +
                                      phx[0] * _s11(i - 2, j + rj0, 0) +
                                      phx[1] * _s11(i - 1, j + rj0, 0) +
                                      phx[3] * _s11(i + 1, j + rj0, 0)) +
                                 dhpzl[k][1] * _g_c(1) *
                                     (phx[2] * _s11(i, j + rj0, 1) +
                                      phx[0] * _s11(i - 2, j + rj0, 1) +
                                      phx[1] * _s11(i - 1, j + rj0, 1) +
                                      phx[3] * _s11(i + 1, j + rj0, 1)) +
                                 dhpzl[k][2] * _g_c(2) *
                                     (phx[2] * _s11(i, j + rj0, 2) +
                                      phx[0] * _s11(i - 2, j + rj0, 2) +
                                      phx[1] * _s11(i - 1, j + rj0, 2) +
                                      phx[3] * _s11(i + 1, j + rj0, 2)) +
                                 dhpzl[k][3] * _g_c(3) *
                                     (phx[2] * _s11(i, j + rj0, 3) +
                                      phx[0] * _s11(i - 2, j + rj0, 3) +
                                      phx[1] * _s11(i - 1, j + rj0, 3) +
                                      phx[3] * _s11(i + 1, j + rj0, 3)) +
                                 dhpzl[k][4] * _g_c(4) *
                                     (phx[2] * _s11(i, j + rj0, 4) +
                                      phx[0] * _s11(i - 2, j + rj0, 4) +
                                      phx[1] * _s11(i - 1, j + rj0, 4) +
                                      phx[3] * _s11(i + 1, j + rj0, 4)) +
                                 dhpzl[k][5] * _g_c(5) *
                                     (phx[2] * _s11(i, j + rj0, 5) +
                                      phx[0] * _s11(i - 2, j + rj0, 5) +
                                      phx[1] * _s11(i - 1, j + rj0, 5) +
                                      phx[3] * _s11(i + 1, j + rj0, 5)) +
                                 dhpzl[k][6] * _g_c(6) *
                                     (phx[2] * _s11(i, j + rj0, 6) +
                                      phx[0] * _s11(i - 2, j + rj0, 6) +
                                      phx[1] * _s11(i - 1, j + rj0, 6) +
                                      phx[3] * _s11(i + 1, j + rj0, 6)) +
                                 dhpzl[k][7] * _g_c(7) *
                                     (phx[2] * _s11(i, j + rj0, 7) +
                                      phx[0] * _s11(i - 2, j + rj0, 7) +
                                      phx[1] * _s11(i - 1, j + rj0, 7) +
                                      phx[3] * _s11(i + 1, j + rj0, 7)) +
                                 dhpzl[k][8] * _g_c(8) *
                                     (phx[2] * _s11(i, j + rj0, 8) +
                                      phx[0] * _s11(i - 2, j + rj0, 8) +
                                      phx[1] * _s11(i - 1, j + rj0, 8) +
                                      phx[3] * _s11(i + 1, j + rj0, 8))) -
            _f2_1(i, j + rj0) * (dhpzl[k][0] * _g_c(0) *
                                     (phy[2] * _s12(i, j + rj0, 0) +
                                      phy[0] * _s12(i, j + rj0 - 2, 0) +
                                      phy[1] * _s12(i, j + rj0 - 1, 0) +
                                      phy[3] * _s12(i, j + rj0 + 1, 0)) +
                                 dhpzl[k][1] * _g_c(1) *
                                     (phy[2] * _s12(i, j + rj0, 1) +
                                      phy[0] * _s12(i, j + rj0 - 2, 1) +
                                      phy[1] * _s12(i, j + rj0 - 1, 1) +
                                      phy[3] * _s12(i, j + rj0 + 1, 1)) +
                                 dhpzl[k][2] * _g_c(2) *
                                     (phy[2] * _s12(i, j + rj0, 2) +
                                      phy[0] * _s12(i, j + rj0 - 2, 2) +
                                      phy[1] * _s12(i, j + rj0 - 1, 2) +
                                      phy[3] * _s12(i, j + rj0 + 1, 2)) +
                                 dhpzl[k][3] * _g_c(3) *
                                     (phy[2] * _s12(i, j + rj0, 3) +
                                      phy[0] * _s12(i, j + rj0 - 2, 3) +
                                      phy[1] * _s12(i, j + rj0 - 1, 3) +
                                      phy[3] * _s12(i, j + rj0 + 1, 3)) +
                                 dhpzl[k][4] * _g_c(4) *
                                     (phy[2] * _s12(i, j + rj0, 4) +
                                      phy[0] * _s12(i, j + rj0 - 2, 4) +
                                      phy[1] * _s12(i, j + rj0 - 1, 4) +
                                      phy[3] * _s12(i, j + rj0 + 1, 4)) +
                                 dhpzl[k][5] * _g_c(5) *
                                     (phy[2] * _s12(i, j + rj0, 5) +
                                      phy[0] * _s12(i, j + rj0 - 2, 5) +
                                      phy[1] * _s12(i, j + rj0 - 1, 5) +
                                      phy[3] * _s12(i, j + rj0 + 1, 5)) +
                                 dhpzl[k][6] * _g_c(6) *
                                     (phy[2] * _s12(i, j + rj0, 6) +
                                      phy[0] * _s12(i, j + rj0 - 2, 6) +
                                      phy[1] * _s12(i, j + rj0 - 1, 6) +
                                      phy[3] * _s12(i, j + rj0 + 1, 6)) +
                                 dhpzl[k][7] * _g_c(7) *
                                     (phy[2] * _s12(i, j + rj0, 7) +
                                      phy[0] * _s12(i, j + rj0 - 2, 7) +
                                      phy[1] * _s12(i, j + rj0 - 1, 7) +
                                      phy[3] * _s12(i, j + rj0 + 1, 7)) +
                                 dhpzl[k][8] * _g_c(8) *
                                     (phy[2] * _s12(i, j + rj0, 8) +
                                      phy[0] * _s12(i, j + rj0 - 2, 8) +
                                      phy[1] * _s12(i, j + rj0 - 1, 8) +
                                      phy[3] * _s12(i, j + rj0 + 1, 8))))) *
      f_dcrj;
  _buf_u2(i, j, k) =
      (a * _u2(i, j + rj0, k) +
       Ai2 *
           (dhzl[k][0] * _s23(i, j + rj0, 0) +
            dhzl[k][1] * _s23(i, j + rj0, 1) +
            dhzl[k][2] * _s23(i, j + rj0, 2) +
            dhzl[k][3] * _s23(i, j + rj0, 3) +
            dhzl[k][4] * _s23(i, j + rj0, 4) +
            dhzl[k][5] * _s23(i, j + rj0, 5) +
            dhzl[k][6] * _s23(i, j + rj0, 6) +
            dx[1] * _f(i, j + rj0) * _g3_c(k) * _s12(i, j + rj0, k) +
            dx[0] * _f(i - 1, j + rj0) * _g3_c(k) * _s12(i - 1, j + rj0, k) +
            dx[2] * _f(i + 1, j + rj0) * _g3_c(k) * _s12(i + 1, j + rj0, k) +
            dx[3] * _f(i + 2, j + rj0) * _g3_c(k) * _s12(i + 2, j + rj0, k) +
            dy[1] * _f_c(i, j + rj0) * _g3_c(k) * _s22(i, j + rj0, k) +
            dy[0] * _f_c(i, j + rj0 - 1) * _g3_c(k) * _s22(i, j + rj0 - 1, k) +
            dy[2] * _f_c(i, j + rj0 + 1) * _g3_c(k) * _s22(i, j + rj0 + 1, k) +
            dy[3] * _f_c(i, j + rj0 + 2) * _g3_c(k) * _s22(i, j + rj0 + 2, k) -
            _f1_2(i, j + rj0) * (dhpzl[k][0] * _g_c(0) *
                                     (px[1] * _s12(i, j + rj0, 0) +
                                      px[0] * _s12(i - 1, j + rj0, 0) +
                                      px[2] * _s12(i + 1, j + rj0, 0) +
                                      px[3] * _s12(i + 2, j + rj0, 0)) +
                                 dhpzl[k][1] * _g_c(1) *
                                     (px[1] * _s12(i, j + rj0, 1) +
                                      px[0] * _s12(i - 1, j + rj0, 1) +
                                      px[2] * _s12(i + 1, j + rj0, 1) +
                                      px[3] * _s12(i + 2, j + rj0, 1)) +
                                 dhpzl[k][2] * _g_c(2) *
                                     (px[1] * _s12(i, j + rj0, 2) +
                                      px[0] * _s12(i - 1, j + rj0, 2) +
                                      px[2] * _s12(i + 1, j + rj0, 2) +
                                      px[3] * _s12(i + 2, j + rj0, 2)) +
                                 dhpzl[k][3] * _g_c(3) *
                                     (px[1] * _s12(i, j + rj0, 3) +
                                      px[0] * _s12(i - 1, j + rj0, 3) +
                                      px[2] * _s12(i + 1, j + rj0, 3) +
                                      px[3] * _s12(i + 2, j + rj0, 3)) +
                                 dhpzl[k][4] * _g_c(4) *
                                     (px[1] * _s12(i, j + rj0, 4) +
                                      px[0] * _s12(i - 1, j + rj0, 4) +
                                      px[2] * _s12(i + 1, j + rj0, 4) +
                                      px[3] * _s12(i + 2, j + rj0, 4)) +
                                 dhpzl[k][5] * _g_c(5) *
                                     (px[1] * _s12(i, j + rj0, 5) +
                                      px[0] * _s12(i - 1, j + rj0, 5) +
                                      px[2] * _s12(i + 1, j + rj0, 5) +
                                      px[3] * _s12(i + 2, j + rj0, 5)) +
                                 dhpzl[k][6] * _g_c(6) *
                                     (px[1] * _s12(i, j + rj0, 6) +
                                      px[0] * _s12(i - 1, j + rj0, 6) +
                                      px[2] * _s12(i + 1, j + rj0, 6) +
                                      px[3] * _s12(i + 2, j + rj0, 6)) +
                                 dhpzl[k][7] * _g_c(7) *
                                     (px[1] * _s12(i, j + rj0, 7) +
                                      px[0] * _s12(i - 1, j + rj0, 7) +
                                      px[2] * _s12(i + 1, j + rj0, 7) +
                                      px[3] * _s12(i + 2, j + rj0, 7)) +
                                 dhpzl[k][8] * _g_c(8) *
                                     (px[1] * _s12(i, j + rj0, 8) +
                                      px[0] * _s12(i - 1, j + rj0, 8) +
                                      px[2] * _s12(i + 1, j + rj0, 8) +
                                      px[3] * _s12(i + 2, j + rj0, 8))) -
            _f2_2(i, j + rj0) * (dhpzl[k][0] * _g_c(0) *
                                     (py[1] * _s22(i, j + rj0, 0) +
                                      py[0] * _s22(i, j + rj0 - 1, 0) +
                                      py[2] * _s22(i, j + rj0 + 1, 0) +
                                      py[3] * _s22(i, j + rj0 + 2, 0)) +
                                 dhpzl[k][1] * _g_c(1) *
                                     (py[1] * _s22(i, j + rj0, 1) +
                                      py[0] * _s22(i, j + rj0 - 1, 1) +
                                      py[2] * _s22(i, j + rj0 + 1, 1) +
                                      py[3] * _s22(i, j + rj0 + 2, 1)) +
                                 dhpzl[k][2] * _g_c(2) *
                                     (py[1] * _s22(i, j + rj0, 2) +
                                      py[0] * _s22(i, j + rj0 - 1, 2) +
                                      py[2] * _s22(i, j + rj0 + 1, 2) +
                                      py[3] * _s22(i, j + rj0 + 2, 2)) +
                                 dhpzl[k][3] * _g_c(3) *
                                     (py[1] * _s22(i, j + rj0, 3) +
                                      py[0] * _s22(i, j + rj0 - 1, 3) +
                                      py[2] * _s22(i, j + rj0 + 1, 3) +
                                      py[3] * _s22(i, j + rj0 + 2, 3)) +
                                 dhpzl[k][4] * _g_c(4) *
                                     (py[1] * _s22(i, j + rj0, 4) +
                                      py[0] * _s22(i, j + rj0 - 1, 4) +
                                      py[2] * _s22(i, j + rj0 + 1, 4) +
                                      py[3] * _s22(i, j + rj0 + 2, 4)) +
                                 dhpzl[k][5] * _g_c(5) *
                                     (py[1] * _s22(i, j + rj0, 5) +
                                      py[0] * _s22(i, j + rj0 - 1, 5) +
                                      py[2] * _s22(i, j + rj0 + 1, 5) +
                                      py[3] * _s22(i, j + rj0 + 2, 5)) +
                                 dhpzl[k][6] * _g_c(6) *
                                     (py[1] * _s22(i, j + rj0, 6) +
                                      py[0] * _s22(i, j + rj0 - 1, 6) +
                                      py[2] * _s22(i, j + rj0 + 1, 6) +
                                      py[3] * _s22(i, j + rj0 + 2, 6)) +
                                 dhpzl[k][7] * _g_c(7) *
                                     (py[1] * _s22(i, j + rj0, 7) +
                                      py[0] * _s22(i, j + rj0 - 1, 7) +
                                      py[2] * _s22(i, j + rj0 + 1, 7) +
                                      py[3] * _s22(i, j + rj0 + 2, 7)) +
                                 dhpzl[k][8] * _g_c(8) *
                                     (py[1] * _s22(i, j + rj0, 8) +
                                      py[0] * _s22(i, j + rj0 - 1, 8) +
                                      py[2] * _s22(i, j + rj0 + 1, 8) +
                                      py[3] * _s22(i, j + rj0 + 2, 8))))) *
      f_dcrj;
  _buf_u3(i, j, k) =
      (a * _u3(i, j + rj0, k) +
       Ai3 *
           (dhy[2] * _f_2(i, j + rj0) * _g3(k) * _s23(i, j + rj0, k) +
            dhy[0] * _f_2(i, j + rj0 - 2) * _g3(k) * _s23(i, j + rj0 - 2, k) +
            dhy[1] * _f_2(i, j + rj0 - 1) * _g3(k) * _s23(i, j + rj0 - 1, k) +
            dhy[3] * _f_2(i, j + rj0 + 1) * _g3(k) * _s23(i, j + rj0 + 1, k) +
            dx[1] * _f_1(i, j + rj0) * _g3(k) * _s13(i, j + rj0, k) +
            dx[0] * _f_1(i - 1, j + rj0) * _g3(k) * _s13(i - 1, j + rj0, k) +
            dx[2] * _f_1(i + 1, j + rj0) * _g3(k) * _s13(i + 1, j + rj0, k) +
            dx[3] * _f_1(i + 2, j + rj0) * _g3(k) * _s13(i + 2, j + rj0, k) +
            dzl[k][0] * _s33(i, j + rj0, 0) + dzl[k][1] * _s33(i, j + rj0, 1) +
            dzl[k][2] * _s33(i, j + rj0, 2) + dzl[k][3] * _s33(i, j + rj0, 3) +
            dzl[k][4] * _s33(i, j + rj0, 4) + dzl[k][5] * _s33(i, j + rj0, 5) +
            dzl[k][6] * _s33(i, j + rj0, 6) + dzl[k][7] * _s33(i, j + rj0, 7) -
            _f1_c(i, j + rj0) * (dphzl[k][0] * _g(0) *
                                     (px[1] * _s13(i, j + rj0, 0) +
                                      px[0] * _s13(i - 1, j + rj0, 0) +
                                      px[2] * _s13(i + 1, j + rj0, 0) +
                                      px[3] * _s13(i + 2, j + rj0, 0)) +
                                 dphzl[k][1] * _g(1) *
                                     (px[1] * _s13(i, j + rj0, 1) +
                                      px[0] * _s13(i - 1, j + rj0, 1) +
                                      px[2] * _s13(i + 1, j + rj0, 1) +
                                      px[3] * _s13(i + 2, j + rj0, 1)) +
                                 dphzl[k][2] * _g(2) *
                                     (px[1] * _s13(i, j + rj0, 2) +
                                      px[0] * _s13(i - 1, j + rj0, 2) +
                                      px[2] * _s13(i + 1, j + rj0, 2) +
                                      px[3] * _s13(i + 2, j + rj0, 2)) +
                                 dphzl[k][3] * _g(3) *
                                     (px[1] * _s13(i, j + rj0, 3) +
                                      px[0] * _s13(i - 1, j + rj0, 3) +
                                      px[2] * _s13(i + 1, j + rj0, 3) +
                                      px[3] * _s13(i + 2, j + rj0, 3)) +
                                 dphzl[k][4] * _g(4) *
                                     (px[1] * _s13(i, j + rj0, 4) +
                                      px[0] * _s13(i - 1, j + rj0, 4) +
                                      px[2] * _s13(i + 1, j + rj0, 4) +
                                      px[3] * _s13(i + 2, j + rj0, 4)) +
                                 dphzl[k][5] * _g(5) *
                                     (px[1] * _s13(i, j + rj0, 5) +
                                      px[0] * _s13(i - 1, j + rj0, 5) +
                                      px[2] * _s13(i + 1, j + rj0, 5) +
                                      px[3] * _s13(i + 2, j + rj0, 5)) +
                                 dphzl[k][6] * _g(6) *
                                     (px[1] * _s13(i, j + rj0, 6) +
                                      px[0] * _s13(i - 1, j + rj0, 6) +
                                      px[2] * _s13(i + 1, j + rj0, 6) +
                                      px[3] * _s13(i + 2, j + rj0, 6)) +
                                 dphzl[k][7] * _g(7) *
                                     (px[1] * _s13(i, j + rj0, 7) +
                                      px[0] * _s13(i - 1, j + rj0, 7) +
                                      px[2] * _s13(i + 1, j + rj0, 7) +
                                      px[3] * _s13(i + 2, j + rj0, 7)) +
                                 dphzl[k][8] * _g(8) *
                                     (px[1] * _s13(i, j + rj0, 8) +
                                      px[0] * _s13(i - 1, j + rj0, 8) +
                                      px[2] * _s13(i + 1, j + rj0, 8) +
                                      px[3] * _s13(i + 2, j + rj0, 8))) -
            _f2_c(i, j + rj0) * (dphzl[k][0] * _g(0) *
                                     (phy[2] * _s23(i, j + rj0, 0) +
                                      phy[0] * _s23(i, j + rj0 - 2, 0) +
                                      phy[1] * _s23(i, j + rj0 - 1, 0) +
                                      phy[3] * _s23(i, j + rj0 + 1, 0)) +
                                 dphzl[k][1] * _g(1) *
                                     (phy[2] * _s23(i, j + rj0, 1) +
                                      phy[0] * _s23(i, j + rj0 - 2, 1) +
                                      phy[1] * _s23(i, j + rj0 - 1, 1) +
                                      phy[3] * _s23(i, j + rj0 + 1, 1)) +
                                 dphzl[k][2] * _g(2) *
                                     (phy[2] * _s23(i, j + rj0, 2) +
                                      phy[0] * _s23(i, j + rj0 - 2, 2) +
                                      phy[1] * _s23(i, j + rj0 - 1, 2) +
                                      phy[3] * _s23(i, j + rj0 + 1, 2)) +
                                 dphzl[k][3] * _g(3) *
                                     (phy[2] * _s23(i, j + rj0, 3) +
                                      phy[0] * _s23(i, j + rj0 - 2, 3) +
                                      phy[1] * _s23(i, j + rj0 - 1, 3) +
                                      phy[3] * _s23(i, j + rj0 + 1, 3)) +
                                 dphzl[k][4] * _g(4) *
                                     (phy[2] * _s23(i, j + rj0, 4) +
                                      phy[0] * _s23(i, j + rj0 - 2, 4) +
                                      phy[1] * _s23(i, j + rj0 - 1, 4) +
                                      phy[3] * _s23(i, j + rj0 + 1, 4)) +
                                 dphzl[k][5] * _g(5) *
                                     (phy[2] * _s23(i, j + rj0, 5) +
                                      phy[0] * _s23(i, j + rj0 - 2, 5) +
                                      phy[1] * _s23(i, j + rj0 - 1, 5) +
                                      phy[3] * _s23(i, j + rj0 + 1, 5)) +
                                 dphzl[k][6] * _g(6) *
                                     (phy[2] * _s23(i, j + rj0, 6) +
                                      phy[0] * _s23(i, j + rj0 - 2, 6) +
                                      phy[1] * _s23(i, j + rj0 - 1, 6) +
                                      phy[3] * _s23(i, j + rj0 + 1, 6)) +
                                 dphzl[k][7] * _g(7) *
                                     (phy[2] * _s23(i, j + rj0, 7) +
                                      phy[0] * _s23(i, j + rj0 - 2, 7) +
                                      phy[1] * _s23(i, j + rj0 - 1, 7) +
                                      phy[3] * _s23(i, j + rj0 + 1, 7)) +
                                 dphzl[k][8] * _g(8) *
                                     (phy[2] * _s23(i, j + rj0, 8) +
                                      phy[0] * _s23(i, j + rj0 - 2, 8) +
                                      phy[1] * _s23(i, j + rj0 - 1, 8) +
                                      phy[3] * _s23(i, j + rj0 + 1, 8))))) *
      f_dcrj;
#undef _rho
#undef _f_1
#undef _g3_c
#undef _f_2
#undef _f_c
#undef _g3
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _f
#undef _s13
#undef _u1
#undef _s11
#undef _f2_1
#undef _f1_1
#undef _s12
#undef _g_c
#undef _s23
#undef _f2_2
#undef _s22
#undef _f1_2
#undef _u2
#undef _g
#undef _s33
#undef _f2_c
#undef _f1_c
#undef _u3
#undef _buf_u1
#undef _buf_u2
#undef _buf_u3
}

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
    const int rj0) {
  const float phz[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float dhpz[7] = {-0.0026041666666667, 0.0937500000000000,
                         -0.6796875000000000, 0.0000000000000000,
                         0.6796875000000000,  -0.0937500000000000,
                         0.0026041666666667};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhz[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dphz[7] = {-0.0026041666666667, 0.0937500000000000,
                         -0.6796875000000000, 0.0000000000000000,
                         0.6796875000000000,  -0.0937500000000000,
                         0.0026041666666667};
  const float dz[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const int i = threadIdx.x + blockIdx.x * blockDim.x;
  if (i >= nx)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= nz - 12)
    return;
#define _rho(i, j, k)                                                          \
  rho[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _buf_u1(i, j, k)                                                       \
  buf_u1[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
#define _buf_u2(i, j, k)                                                       \
  buf_u2[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
#define _buf_u3(i, j, k)                                                       \
  buf_u3[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
  float rho1 = phz[0] * (phy[2] * _rho(i, j + rj0, k + 4) +
                         phy[0] * _rho(i, j + rj0 - 2, k + 4) +
                         phy[1] * _rho(i, j + rj0 - 1, k + 4) +
                         phy[3] * _rho(i, j + rj0 + 1, k + 4)) +
               phz[1] * (phy[2] * _rho(i, j + rj0, k + 5) +
                         phy[0] * _rho(i, j + rj0 - 2, k + 5) +
                         phy[1] * _rho(i, j + rj0 - 1, k + 5) +
                         phy[3] * _rho(i, j + rj0 + 1, k + 5)) +
               phz[2] * (phy[2] * _rho(i, j + rj0, k + 6) +
                         phy[0] * _rho(i, j + rj0 - 2, k + 6) +
                         phy[1] * _rho(i, j + rj0 - 1, k + 6) +
                         phy[3] * _rho(i, j + rj0 + 1, k + 6)) +
               phz[3] * (phy[2] * _rho(i, j + rj0, k + 7) +
                         phy[0] * _rho(i, j + rj0 - 2, k + 7) +
                         phy[1] * _rho(i, j + rj0 - 1, k + 7) +
                         phy[3] * _rho(i, j + rj0 + 1, k + 7));
  float rho2 = phz[0] * (phx[2] * _rho(i, j + rj0, k + 4) +
                         phx[0] * _rho(i - 2, j + rj0, k + 4) +
                         phx[1] * _rho(i - 1, j + rj0, k + 4) +
                         phx[3] * _rho(i + 1, j + rj0, k + 4)) +
               phz[1] * (phx[2] * _rho(i, j + rj0, k + 5) +
                         phx[0] * _rho(i - 2, j + rj0, k + 5) +
                         phx[1] * _rho(i - 1, j + rj0, k + 5) +
                         phx[3] * _rho(i + 1, j + rj0, k + 5)) +
               phz[2] * (phx[2] * _rho(i, j + rj0, k + 6) +
                         phx[0] * _rho(i - 2, j + rj0, k + 6) +
                         phx[1] * _rho(i - 1, j + rj0, k + 6) +
                         phx[3] * _rho(i + 1, j + rj0, k + 6)) +
               phz[3] * (phx[2] * _rho(i, j + rj0, k + 7) +
                         phx[0] * _rho(i - 2, j + rj0, k + 7) +
                         phx[1] * _rho(i - 1, j + rj0, k + 7) +
                         phx[3] * _rho(i + 1, j + rj0, k + 7));
  float rho3 = phy[2] * (phx[2] * _rho(i, j + rj0, k + 6) +
                         phx[0] * _rho(i - 2, j + rj0, k + 6) +
                         phx[1] * _rho(i - 1, j + rj0, k + 6) +
                         phx[3] * _rho(i + 1, j + rj0, k + 6)) +
               phy[0] * (phx[2] * _rho(i, j + rj0 - 2, k + 6) +
                         phx[0] * _rho(i - 2, j + rj0 - 2, k + 6) +
                         phx[1] * _rho(i - 1, j + rj0 - 2, k + 6) +
                         phx[3] * _rho(i + 1, j + rj0 - 2, k + 6)) +
               phy[1] * (phx[2] * _rho(i, j + rj0 - 1, k + 6) +
                         phx[0] * _rho(i - 2, j + rj0 - 1, k + 6) +
                         phx[1] * _rho(i - 1, j + rj0 - 1, k + 6) +
                         phx[3] * _rho(i + 1, j + rj0 - 1, k + 6)) +
               phy[3] * (phx[2] * _rho(i, j + rj0 + 1, k + 6) +
                         phx[0] * _rho(i - 2, j + rj0 + 1, k + 6) +
                         phx[1] * _rho(i - 1, j + rj0 + 1, k + 6) +
                         phx[3] * _rho(i + 1, j + rj0 + 1, k + 6));
  float Ai1 = _f_1(i, j + rj0) * _g3_c(k + 6) * rho1;
  Ai1 = nu * 1.0 / Ai1;
  float Ai2 = _f_2(i, j + rj0) * _g3_c(k + 6) * rho2;
  Ai2 = nu * 1.0 / Ai2;
  float Ai3 = _f_c(i, j + rj0) * _g3(k + 6) * rho3;
  Ai3 = nu * 1.0 / Ai3;
  float f_dcrj = _dcrjx(i) * _dcrjy(j + rj0) * _dcrjz(k + 6);
  _buf_u1(i, j, k + 6) =
      (a * _u1(i, j + rj0, k + 6) +
       Ai1 *
           (dhx[2] * _f_c(i, j + rj0) * _g3_c(k + 6) * _s11(i, j + rj0, k + 6) +
            dhx[0] * _f_c(i - 2, j + rj0) * _g3_c(k + 6) *
                _s11(i - 2, j + rj0, k + 6) +
            dhx[1] * _f_c(i - 1, j + rj0) * _g3_c(k + 6) *
                _s11(i - 1, j + rj0, k + 6) +
            dhx[3] * _f_c(i + 1, j + rj0) * _g3_c(k + 6) *
                _s11(i + 1, j + rj0, k + 6) +
            dhy[2] * _f(i, j + rj0) * _g3_c(k + 6) * _s12(i, j + rj0, k + 6) +
            dhy[0] * _f(i, j + rj0 - 2) * _g3_c(k + 6) *
                _s12(i, j + rj0 - 2, k + 6) +
            dhy[1] * _f(i, j + rj0 - 1) * _g3_c(k + 6) *
                _s12(i, j + rj0 - 1, k + 6) +
            dhy[3] * _f(i, j + rj0 + 1) * _g3_c(k + 6) *
                _s12(i, j + rj0 + 1, k + 6) +
            dhz[0] * _s13(i, j + rj0, k + 4) +
            dhz[1] * _s13(i, j + rj0, k + 5) +
            dhz[2] * _s13(i, j + rj0, k + 6) +
            dhz[3] * _s13(i, j + rj0, k + 7) -
            _f1_1(i, j + rj0) * (dhpz[0] * _g_c(k + 3) *
                                     (phx[2] * _s11(i, j + rj0, k + 3) +
                                      phx[0] * _s11(i - 2, j + rj0, k + 3) +
                                      phx[1] * _s11(i - 1, j + rj0, k + 3) +
                                      phx[3] * _s11(i + 1, j + rj0, k + 3)) +
                                 dhpz[1] * _g_c(k + 4) *
                                     (phx[2] * _s11(i, j + rj0, k + 4) +
                                      phx[0] * _s11(i - 2, j + rj0, k + 4) +
                                      phx[1] * _s11(i - 1, j + rj0, k + 4) +
                                      phx[3] * _s11(i + 1, j + rj0, k + 4)) +
                                 dhpz[2] * _g_c(k + 5) *
                                     (phx[2] * _s11(i, j + rj0, k + 5) +
                                      phx[0] * _s11(i - 2, j + rj0, k + 5) +
                                      phx[1] * _s11(i - 1, j + rj0, k + 5) +
                                      phx[3] * _s11(i + 1, j + rj0, k + 5)) +
                                 dhpz[3] * _g_c(k + 6) *
                                     (phx[2] * _s11(i, j + rj0, k + 6) +
                                      phx[0] * _s11(i - 2, j + rj0, k + 6) +
                                      phx[1] * _s11(i - 1, j + rj0, k + 6) +
                                      phx[3] * _s11(i + 1, j + rj0, k + 6)) +
                                 dhpz[4] * _g_c(k + 7) *
                                     (phx[2] * _s11(i, j + rj0, k + 7) +
                                      phx[0] * _s11(i - 2, j + rj0, k + 7) +
                                      phx[1] * _s11(i - 1, j + rj0, k + 7) +
                                      phx[3] * _s11(i + 1, j + rj0, k + 7)) +
                                 dhpz[5] * _g_c(k + 8) *
                                     (phx[2] * _s11(i, j + rj0, k + 8) +
                                      phx[0] * _s11(i - 2, j + rj0, k + 8) +
                                      phx[1] * _s11(i - 1, j + rj0, k + 8) +
                                      phx[3] * _s11(i + 1, j + rj0, k + 8)) +
                                 dhpz[6] * _g_c(k + 9) *
                                     (phx[2] * _s11(i, j + rj0, k + 9) +
                                      phx[0] * _s11(i - 2, j + rj0, k + 9) +
                                      phx[1] * _s11(i - 1, j + rj0, k + 9) +
                                      phx[3] * _s11(i + 1, j + rj0, k + 9))) -
            _f2_1(i, j + rj0) * (dhpz[0] * _g_c(k + 3) *
                                     (phy[2] * _s12(i, j + rj0, k + 3) +
                                      phy[0] * _s12(i, j + rj0 - 2, k + 3) +
                                      phy[1] * _s12(i, j + rj0 - 1, k + 3) +
                                      phy[3] * _s12(i, j + rj0 + 1, k + 3)) +
                                 dhpz[1] * _g_c(k + 4) *
                                     (phy[2] * _s12(i, j + rj0, k + 4) +
                                      phy[0] * _s12(i, j + rj0 - 2, k + 4) +
                                      phy[1] * _s12(i, j + rj0 - 1, k + 4) +
                                      phy[3] * _s12(i, j + rj0 + 1, k + 4)) +
                                 dhpz[2] * _g_c(k + 5) *
                                     (phy[2] * _s12(i, j + rj0, k + 5) +
                                      phy[0] * _s12(i, j + rj0 - 2, k + 5) +
                                      phy[1] * _s12(i, j + rj0 - 1, k + 5) +
                                      phy[3] * _s12(i, j + rj0 + 1, k + 5)) +
                                 dhpz[3] * _g_c(k + 6) *
                                     (phy[2] * _s12(i, j + rj0, k + 6) +
                                      phy[0] * _s12(i, j + rj0 - 2, k + 6) +
                                      phy[1] * _s12(i, j + rj0 - 1, k + 6) +
                                      phy[3] * _s12(i, j + rj0 + 1, k + 6)) +
                                 dhpz[4] * _g_c(k + 7) *
                                     (phy[2] * _s12(i, j + rj0, k + 7) +
                                      phy[0] * _s12(i, j + rj0 - 2, k + 7) +
                                      phy[1] * _s12(i, j + rj0 - 1, k + 7) +
                                      phy[3] * _s12(i, j + rj0 + 1, k + 7)) +
                                 dhpz[5] * _g_c(k + 8) *
                                     (phy[2] * _s12(i, j + rj0, k + 8) +
                                      phy[0] * _s12(i, j + rj0 - 2, k + 8) +
                                      phy[1] * _s12(i, j + rj0 - 1, k + 8) +
                                      phy[3] * _s12(i, j + rj0 + 1, k + 8)) +
                                 dhpz[6] * _g_c(k + 9) *
                                     (phy[2] * _s12(i, j + rj0, k + 9) +
                                      phy[0] * _s12(i, j + rj0 - 2, k + 9) +
                                      phy[1] * _s12(i, j + rj0 - 1, k + 9) +
                                      phy[3] * _s12(i, j + rj0 + 1, k + 9))))) *
      f_dcrj;
  _buf_u2(i, j, k + 6) =
      (a * _u2(i, j + rj0, k + 6) +
       Ai2 *
           (dhz[0] * _s23(i, j + rj0, k + 4) +
            dhz[1] * _s23(i, j + rj0, k + 5) +
            dhz[2] * _s23(i, j + rj0, k + 6) +
            dhz[3] * _s23(i, j + rj0, k + 7) +
            dx[1] * _f(i, j + rj0) * _g3_c(k + 6) * _s12(i, j + rj0, k + 6) +
            dx[0] * _f(i - 1, j + rj0) * _g3_c(k + 6) *
                _s12(i - 1, j + rj0, k + 6) +
            dx[2] * _f(i + 1, j + rj0) * _g3_c(k + 6) *
                _s12(i + 1, j + rj0, k + 6) +
            dx[3] * _f(i + 2, j + rj0) * _g3_c(k + 6) *
                _s12(i + 2, j + rj0, k + 6) +
            dy[1] * _f_c(i, j + rj0) * _g3_c(k + 6) * _s22(i, j + rj0, k + 6) +
            dy[0] * _f_c(i, j + rj0 - 1) * _g3_c(k + 6) *
                _s22(i, j + rj0 - 1, k + 6) +
            dy[2] * _f_c(i, j + rj0 + 1) * _g3_c(k + 6) *
                _s22(i, j + rj0 + 1, k + 6) +
            dy[3] * _f_c(i, j + rj0 + 2) * _g3_c(k + 6) *
                _s22(i, j + rj0 + 2, k + 6) -
            _f1_2(i, j + rj0) * (dhpz[0] * _g_c(k + 3) *
                                     (px[1] * _s12(i, j + rj0, k + 3) +
                                      px[0] * _s12(i - 1, j + rj0, k + 3) +
                                      px[2] * _s12(i + 1, j + rj0, k + 3) +
                                      px[3] * _s12(i + 2, j + rj0, k + 3)) +
                                 dhpz[1] * _g_c(k + 4) *
                                     (px[1] * _s12(i, j + rj0, k + 4) +
                                      px[0] * _s12(i - 1, j + rj0, k + 4) +
                                      px[2] * _s12(i + 1, j + rj0, k + 4) +
                                      px[3] * _s12(i + 2, j + rj0, k + 4)) +
                                 dhpz[2] * _g_c(k + 5) *
                                     (px[1] * _s12(i, j + rj0, k + 5) +
                                      px[0] * _s12(i - 1, j + rj0, k + 5) +
                                      px[2] * _s12(i + 1, j + rj0, k + 5) +
                                      px[3] * _s12(i + 2, j + rj0, k + 5)) +
                                 dhpz[3] * _g_c(k + 6) *
                                     (px[1] * _s12(i, j + rj0, k + 6) +
                                      px[0] * _s12(i - 1, j + rj0, k + 6) +
                                      px[2] * _s12(i + 1, j + rj0, k + 6) +
                                      px[3] * _s12(i + 2, j + rj0, k + 6)) +
                                 dhpz[4] * _g_c(k + 7) *
                                     (px[1] * _s12(i, j + rj0, k + 7) +
                                      px[0] * _s12(i - 1, j + rj0, k + 7) +
                                      px[2] * _s12(i + 1, j + rj0, k + 7) +
                                      px[3] * _s12(i + 2, j + rj0, k + 7)) +
                                 dhpz[5] * _g_c(k + 8) *
                                     (px[1] * _s12(i, j + rj0, k + 8) +
                                      px[0] * _s12(i - 1, j + rj0, k + 8) +
                                      px[2] * _s12(i + 1, j + rj0, k + 8) +
                                      px[3] * _s12(i + 2, j + rj0, k + 8)) +
                                 dhpz[6] * _g_c(k + 9) *
                                     (px[1] * _s12(i, j + rj0, k + 9) +
                                      px[0] * _s12(i - 1, j + rj0, k + 9) +
                                      px[2] * _s12(i + 1, j + rj0, k + 9) +
                                      px[3] * _s12(i + 2, j + rj0, k + 9))) -
            _f2_2(i, j + rj0) * (dhpz[0] * _g_c(k + 3) *
                                     (py[1] * _s22(i, j + rj0, k + 3) +
                                      py[0] * _s22(i, j + rj0 - 1, k + 3) +
                                      py[2] * _s22(i, j + rj0 + 1, k + 3) +
                                      py[3] * _s22(i, j + rj0 + 2, k + 3)) +
                                 dhpz[1] * _g_c(k + 4) *
                                     (py[1] * _s22(i, j + rj0, k + 4) +
                                      py[0] * _s22(i, j + rj0 - 1, k + 4) +
                                      py[2] * _s22(i, j + rj0 + 1, k + 4) +
                                      py[3] * _s22(i, j + rj0 + 2, k + 4)) +
                                 dhpz[2] * _g_c(k + 5) *
                                     (py[1] * _s22(i, j + rj0, k + 5) +
                                      py[0] * _s22(i, j + rj0 - 1, k + 5) +
                                      py[2] * _s22(i, j + rj0 + 1, k + 5) +
                                      py[3] * _s22(i, j + rj0 + 2, k + 5)) +
                                 dhpz[3] * _g_c(k + 6) *
                                     (py[1] * _s22(i, j + rj0, k + 6) +
                                      py[0] * _s22(i, j + rj0 - 1, k + 6) +
                                      py[2] * _s22(i, j + rj0 + 1, k + 6) +
                                      py[3] * _s22(i, j + rj0 + 2, k + 6)) +
                                 dhpz[4] * _g_c(k + 7) *
                                     (py[1] * _s22(i, j + rj0, k + 7) +
                                      py[0] * _s22(i, j + rj0 - 1, k + 7) +
                                      py[2] * _s22(i, j + rj0 + 1, k + 7) +
                                      py[3] * _s22(i, j + rj0 + 2, k + 7)) +
                                 dhpz[5] * _g_c(k + 8) *
                                     (py[1] * _s22(i, j + rj0, k + 8) +
                                      py[0] * _s22(i, j + rj0 - 1, k + 8) +
                                      py[2] * _s22(i, j + rj0 + 1, k + 8) +
                                      py[3] * _s22(i, j + rj0 + 2, k + 8)) +
                                 dhpz[6] * _g_c(k + 9) *
                                     (py[1] * _s22(i, j + rj0, k + 9) +
                                      py[0] * _s22(i, j + rj0 - 1, k + 9) +
                                      py[2] * _s22(i, j + rj0 + 1, k + 9) +
                                      py[3] * _s22(i, j + rj0 + 2, k + 9))))) *
      f_dcrj;
  _buf_u3(i, j, k + 6) =
      (a * _u3(i, j + rj0, k + 6) +
       Ai3 *
           (dhy[2] * _f_2(i, j + rj0) * _g3(k + 6) * _s23(i, j + rj0, k + 6) +
            dhy[0] * _f_2(i, j + rj0 - 2) * _g3(k + 6) *
                _s23(i, j + rj0 - 2, k + 6) +
            dhy[1] * _f_2(i, j + rj0 - 1) * _g3(k + 6) *
                _s23(i, j + rj0 - 1, k + 6) +
            dhy[3] * _f_2(i, j + rj0 + 1) * _g3(k + 6) *
                _s23(i, j + rj0 + 1, k + 6) +
            dx[1] * _f_1(i, j + rj0) * _g3(k + 6) * _s13(i, j + rj0, k + 6) +
            dx[0] * _f_1(i - 1, j + rj0) * _g3(k + 6) *
                _s13(i - 1, j + rj0, k + 6) +
            dx[2] * _f_1(i + 1, j + rj0) * _g3(k + 6) *
                _s13(i + 1, j + rj0, k + 6) +
            dx[3] * _f_1(i + 2, j + rj0) * _g3(k + 6) *
                _s13(i + 2, j + rj0, k + 6) +
            dz[0] * _s33(i, j + rj0, k + 5) + dz[1] * _s33(i, j + rj0, k + 6) +
            dz[2] * _s33(i, j + rj0, k + 7) + dz[3] * _s33(i, j + rj0, k + 8) -
            _f1_c(i, j + rj0) * (dphz[0] * _g(k + 3) *
                                     (px[1] * _s13(i, j + rj0, k + 3) +
                                      px[0] * _s13(i - 1, j + rj0, k + 3) +
                                      px[2] * _s13(i + 1, j + rj0, k + 3) +
                                      px[3] * _s13(i + 2, j + rj0, k + 3)) +
                                 dphz[1] * _g(k + 4) *
                                     (px[1] * _s13(i, j + rj0, k + 4) +
                                      px[0] * _s13(i - 1, j + rj0, k + 4) +
                                      px[2] * _s13(i + 1, j + rj0, k + 4) +
                                      px[3] * _s13(i + 2, j + rj0, k + 4)) +
                                 dphz[2] * _g(k + 5) *
                                     (px[1] * _s13(i, j + rj0, k + 5) +
                                      px[0] * _s13(i - 1, j + rj0, k + 5) +
                                      px[2] * _s13(i + 1, j + rj0, k + 5) +
                                      px[3] * _s13(i + 2, j + rj0, k + 5)) +
                                 dphz[3] * _g(k + 6) *
                                     (px[1] * _s13(i, j + rj0, k + 6) +
                                      px[0] * _s13(i - 1, j + rj0, k + 6) +
                                      px[2] * _s13(i + 1, j + rj0, k + 6) +
                                      px[3] * _s13(i + 2, j + rj0, k + 6)) +
                                 dphz[4] * _g(k + 7) *
                                     (px[1] * _s13(i, j + rj0, k + 7) +
                                      px[0] * _s13(i - 1, j + rj0, k + 7) +
                                      px[2] * _s13(i + 1, j + rj0, k + 7) +
                                      px[3] * _s13(i + 2, j + rj0, k + 7)) +
                                 dphz[5] * _g(k + 8) *
                                     (px[1] * _s13(i, j + rj0, k + 8) +
                                      px[0] * _s13(i - 1, j + rj0, k + 8) +
                                      px[2] * _s13(i + 1, j + rj0, k + 8) +
                                      px[3] * _s13(i + 2, j + rj0, k + 8)) +
                                 dphz[6] * _g(k + 9) *
                                     (px[1] * _s13(i, j + rj0, k + 9) +
                                      px[0] * _s13(i - 1, j + rj0, k + 9) +
                                      px[2] * _s13(i + 1, j + rj0, k + 9) +
                                      px[3] * _s13(i + 2, j + rj0, k + 9))) -
            _f2_c(i, j + rj0) * (dphz[0] * _g(k + 3) *
                                     (phy[2] * _s23(i, j + rj0, k + 3) +
                                      phy[0] * _s23(i, j + rj0 - 2, k + 3) +
                                      phy[1] * _s23(i, j + rj0 - 1, k + 3) +
                                      phy[3] * _s23(i, j + rj0 + 1, k + 3)) +
                                 dphz[1] * _g(k + 4) *
                                     (phy[2] * _s23(i, j + rj0, k + 4) +
                                      phy[0] * _s23(i, j + rj0 - 2, k + 4) +
                                      phy[1] * _s23(i, j + rj0 - 1, k + 4) +
                                      phy[3] * _s23(i, j + rj0 + 1, k + 4)) +
                                 dphz[2] * _g(k + 5) *
                                     (phy[2] * _s23(i, j + rj0, k + 5) +
                                      phy[0] * _s23(i, j + rj0 - 2, k + 5) +
                                      phy[1] * _s23(i, j + rj0 - 1, k + 5) +
                                      phy[3] * _s23(i, j + rj0 + 1, k + 5)) +
                                 dphz[3] * _g(k + 6) *
                                     (phy[2] * _s23(i, j + rj0, k + 6) +
                                      phy[0] * _s23(i, j + rj0 - 2, k + 6) +
                                      phy[1] * _s23(i, j + rj0 - 1, k + 6) +
                                      phy[3] * _s23(i, j + rj0 + 1, k + 6)) +
                                 dphz[4] * _g(k + 7) *
                                     (phy[2] * _s23(i, j + rj0, k + 7) +
                                      phy[0] * _s23(i, j + rj0 - 2, k + 7) +
                                      phy[1] * _s23(i, j + rj0 - 1, k + 7) +
                                      phy[3] * _s23(i, j + rj0 + 1, k + 7)) +
                                 dphz[5] * _g(k + 8) *
                                     (phy[2] * _s23(i, j + rj0, k + 8) +
                                      phy[0] * _s23(i, j + rj0 - 2, k + 8) +
                                      phy[1] * _s23(i, j + rj0 - 1, k + 8) +
                                      phy[3] * _s23(i, j + rj0 + 1, k + 8)) +
                                 dphz[6] * _g(k + 9) *
                                     (phy[2] * _s23(i, j + rj0, k + 9) +
                                      phy[0] * _s23(i, j + rj0 - 2, k + 9) +
                                      phy[1] * _s23(i, j + rj0 - 1, k + 9) +
                                      phy[3] * _s23(i, j + rj0 + 1, k + 9))))) *
      f_dcrj;
#undef _rho
#undef _f_1
#undef _g3_c
#undef _f_2
#undef _f_c
#undef _g3
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _f
#undef _s13
#undef _u1
#undef _s11
#undef _f2_1
#undef _f1_1
#undef _s12
#undef _g_c
#undef _s23
#undef _f2_2
#undef _s22
#undef _f1_2
#undef _u2
#undef _g
#undef _s33
#undef _f2_c
#undef _f1_c
#undef _u3
#undef _buf_u1
#undef _buf_u2
#undef _buf_u3
}

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
    const int rj0) {
  const float phzr[6][8] = {
      {0.0000000000000000, 0.8338228784688313, 0.1775123316429260,
       0.1435067013076542, -0.1548419114194114, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.1813404047323969, 1.1246711188154426,
       -0.2933634518280757, -0.0126480717197637, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.1331142706282399, 0.7930714675884345,
       0.3131998767078508, 0.0268429263319546, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0969078556633046, -0.1539344946680898,
       0.4486491202844389, 0.6768738207821733, -0.0684963020618270,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0625000000000000, 0.5625000000000000, 0.5625000000000000,
       -0.0625000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, -0.0625000000000000, 0.5625000000000000,
       0.5625000000000000, -0.0625000000000000}};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float dhpzr[6][9] = {
      {-1.5373923010673118, -1.1059180740634813, -0.2134752473866528,
       -0.0352027995732726, -0.0075022330101095, -0.0027918394266035,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.8139439685257414, 0.1273679143938725, -1.1932750007455710,
       0.1475120181828087, 0.1125814499297686, -0.0081303502866204,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.1639182541610305, 0.3113839909089030, -0.0536007135209480,
       -0.3910958927076030, -0.0401741813821989, 0.0095685425408165,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0171478318814576, -0.0916600077207278, 0.7187220404622645,
       -0.1434031863528334, -0.5827389738506837, 0.0847863081664324,
       -0.0028540125859095, 0.0000000000000000, 0.0000000000000000},
      {-0.0579176640853654, 0.0022069616616207, 0.0108792602269819,
       0.6803612607837533, -0.0530169938441240, -0.6736586580761996,
       0.0937500000000000, -0.0026041666666667, 0.0000000000000000},
      {0.0020323834153791, 0.0002106933140862, -0.0013351454085978,
       -0.0938400881871787, 0.6816971139746001, -0.0002232904416222,
       -0.6796875000000000, 0.0937500000000000, -0.0026041666666667}};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dhzr[6][8] = {
      {0.0000000000000000, -1.4511412472637157, -1.8534237417911470,
       0.3534237417911469, 0.0488587527362844, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.8577143189081458, -0.5731429567244373,
       -0.4268570432755628, 0.1422856810918542, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.1674548505882877, 0.4976354482351368,
       -0.4976354482351368, -0.1674548505882877, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.1027061113405124, 0.2624541326469860,
       0.8288742701021167, -1.0342864927831414, 0.0456642013745513,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0416666666666667, 1.1250000000000000, -1.1250000000000000,
       0.0416666666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, -0.0416666666666667, 1.1250000000000000,
       -1.1250000000000000, 0.0416666666666667}};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dphzr[6][9] = {
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -1.5886075042755421, -2.4835574634505861,
       0.0421173406787286, 0.4968761536590695, -0.0228264197210198,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.4428256655817484, -0.0574614517751294,
       -0.2022259589759502, -0.1944663890497050, 0.0113281342190362,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.3360140866060758, 1.2113298407847195,
       -0.3111668377093505, -0.6714462506479002, 0.1111440843153523,
       -0.0038467501367455, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0338560531369653, -0.0409943223643902,
       0.5284757132923059, 0.0115571196122084, -0.6162252315536446,
       0.0857115441015996, -0.0023808762250444, 0.0000000000000000},
      {0.0000000000000000, -0.0040378273193044, 0.0064139372778371,
       -0.0890062133451850, 0.6749219241340761, 0.0002498459192428,
       -0.6796875000000000, 0.0937500000000000, -0.0026041666666667}};
  const float dzr[6][7] = {
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-1.7779989465546753, -1.3337480247900155, -0.7775013168066564,
       0.3332503950419969, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.4410217341392059, 0.1730842484889890, -0.4487228323259926,
       -0.1653831503022022, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1798793213882701, 0.2757257254150788, 0.9597948548284453,
       -1.1171892610431817, 0.0615480021879277, 0.0000000000000000,
       0.0000000000000000},
      {-0.0153911381507088, -0.0568851455503591, 0.1998976464597171,
       0.8628231468598346, -1.0285385292191949, 0.0380940196007109,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0416666666666667, 1.1250000000000000, -1.1250000000000000,
       0.0416666666666667}};
  const int i = threadIdx.x + blockIdx.x * blockDim.x;
  if (i >= nx)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= 6)
    return;
#define _rho(i, j, k)                                                          \
  rho[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _buf_u1(i, j, k)                                                       \
  buf_u1[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
#define _buf_u2(i, j, k)                                                       \
  buf_u2[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
#define _buf_u3(i, j, k)                                                       \
  buf_u3[(j) * (2 * align + nz) + (k) + align +                                \
         ngsl * (2 * align + nz) * ((i) + ngsl + 2)]
  float rho1 = phzr[k][7] * (phy[2] * _rho(i, j + rj0, nz - 8) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 8) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 8) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 8)) +
               phzr[k][6] * (phy[2] * _rho(i, j + rj0, nz - 7) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 7) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 7) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 7)) +
               phzr[k][5] * (phy[2] * _rho(i, j + rj0, nz - 6) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 6) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 6) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 6)) +
               phzr[k][4] * (phy[2] * _rho(i, j + rj0, nz - 5) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 5) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 5) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 5)) +
               phzr[k][3] * (phy[2] * _rho(i, j + rj0, nz - 4) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 4) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 4) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 4)) +
               phzr[k][2] * (phy[2] * _rho(i, j + rj0, nz - 3) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 3) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 3) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 3)) +
               phzr[k][1] * (phy[2] * _rho(i, j + rj0, nz - 2) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 2) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 2) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 2)) +
               phzr[k][0] * (phy[2] * _rho(i, j + rj0, nz - 1) +
                             phy[0] * _rho(i, j + rj0 - 2, nz - 1) +
                             phy[1] * _rho(i, j + rj0 - 1, nz - 1) +
                             phy[3] * _rho(i, j + rj0 + 1, nz - 1));
  float rho2 = phzr[k][7] * (phx[2] * _rho(i, j + rj0, nz - 8) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 8) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 8) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 8)) +
               phzr[k][6] * (phx[2] * _rho(i, j + rj0, nz - 7) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 7) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 7) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 7)) +
               phzr[k][5] * (phx[2] * _rho(i, j + rj0, nz - 6) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 6) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 6) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 6)) +
               phzr[k][4] * (phx[2] * _rho(i, j + rj0, nz - 5) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 5) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 5) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 5)) +
               phzr[k][3] * (phx[2] * _rho(i, j + rj0, nz - 4) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 4) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 4) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 4)) +
               phzr[k][2] * (phx[2] * _rho(i, j + rj0, nz - 3) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 3) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 3) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 3)) +
               phzr[k][1] * (phx[2] * _rho(i, j + rj0, nz - 2) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 2) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 2) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 2)) +
               phzr[k][0] * (phx[2] * _rho(i, j + rj0, nz - 1) +
                             phx[0] * _rho(i - 2, j + rj0, nz - 1) +
                             phx[1] * _rho(i - 1, j + rj0, nz - 1) +
                             phx[3] * _rho(i + 1, j + rj0, nz - 1));
  float rho3 = phy[2] * (phx[2] * _rho(i, j + rj0, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j + rj0, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j + rj0, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j + rj0, nz - 1 - k)) +
               phy[0] * (phx[2] * _rho(i, j + rj0 - 2, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j + rj0 - 2, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j + rj0 - 2, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j + rj0 - 2, nz - 1 - k)) +
               phy[1] * (phx[2] * _rho(i, j + rj0 - 1, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j + rj0 - 1, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j + rj0 - 1, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j + rj0 - 1, nz - 1 - k)) +
               phy[3] * (phx[2] * _rho(i, j + rj0 + 1, nz - 1 - k) +
                         phx[0] * _rho(i - 2, j + rj0 + 1, nz - 1 - k) +
                         phx[1] * _rho(i - 1, j + rj0 + 1, nz - 1 - k) +
                         phx[3] * _rho(i + 1, j + rj0 + 1, nz - 1 - k));
  float Ai1 = _f_1(i, j + rj0) * _g3_c(nz - 1 - k) * rho1;
  Ai1 = nu * 1.0 / Ai1;
  float Ai2 = _f_2(i, j + rj0) * _g3_c(nz - 1 - k) * rho2;
  Ai2 = nu * 1.0 / Ai2;
  float Ai3 = _f_c(i, j + rj0) * _g3(nz - 1 - k) * rho3;
  Ai3 = nu * 1.0 / Ai3;
  float f_dcrj = _dcrjx(i) * _dcrjy(j + rj0) * _dcrjz(nz - 1 - k);
  _buf_u1(i, j, nz - 1 - k) =
      (a * _u1(i, j + rj0, nz - 1 - k) +
       Ai1 *
           (dhx[2] * _f_c(i, j + rj0) * _g3_c(nz - 1 - k) *
                _s11(i, j + rj0, nz - 1 - k) +
            dhx[0] * _f_c(i - 2, j + rj0) * _g3_c(nz - 1 - k) *
                _s11(i - 2, j + rj0, nz - 1 - k) +
            dhx[1] * _f_c(i - 1, j + rj0) * _g3_c(nz - 1 - k) *
                _s11(i - 1, j + rj0, nz - 1 - k) +
            dhx[3] * _f_c(i + 1, j + rj0) * _g3_c(nz - 1 - k) *
                _s11(i + 1, j + rj0, nz - 1 - k) +
            dhy[2] * _f(i, j + rj0) * _g3_c(nz - 1 - k) *
                _s12(i, j + rj0, nz - 1 - k) +
            dhy[0] * _f(i, j + rj0 - 2) * _g3_c(nz - 1 - k) *
                _s12(i, j + rj0 - 2, nz - 1 - k) +
            dhy[1] * _f(i, j + rj0 - 1) * _g3_c(nz - 1 - k) *
                _s12(i, j + rj0 - 1, nz - 1 - k) +
            dhy[3] * _f(i, j + rj0 + 1) * _g3_c(nz - 1 - k) *
                _s12(i, j + rj0 + 1, nz - 1 - k) +
            dhzr[k][7] * _s13(i, j + rj0, nz - 8) +
            dhzr[k][6] * _s13(i, j + rj0, nz - 7) +
            dhzr[k][5] * _s13(i, j + rj0, nz - 6) +
            dhzr[k][4] * _s13(i, j + rj0, nz - 5) +
            dhzr[k][3] * _s13(i, j + rj0, nz - 4) +
            dhzr[k][2] * _s13(i, j + rj0, nz - 3) +
            dhzr[k][1] * _s13(i, j + rj0, nz - 2) +
            dhzr[k][0] * _s13(i, j + rj0, nz - 1) -
            _f1_1(i, j + rj0) * (dhpzr[k][8] * _g_c(nz - 9) *
                                     (phx[2] * _s11(i, j + rj0, nz - 9) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 9) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 9) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 9)) +
                                 dhpzr[k][7] * _g_c(nz - 8) *
                                     (phx[2] * _s11(i, j + rj0, nz - 8) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 8) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 8) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 8)) +
                                 dhpzr[k][6] * _g_c(nz - 7) *
                                     (phx[2] * _s11(i, j + rj0, nz - 7) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 7) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 7) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 7)) +
                                 dhpzr[k][5] * _g_c(nz - 6) *
                                     (phx[2] * _s11(i, j + rj0, nz - 6) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 6) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 6) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 6)) +
                                 dhpzr[k][4] * _g_c(nz - 5) *
                                     (phx[2] * _s11(i, j + rj0, nz - 5) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 5) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 5) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 5)) +
                                 dhpzr[k][3] * _g_c(nz - 4) *
                                     (phx[2] * _s11(i, j + rj0, nz - 4) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 4) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 4) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 4)) +
                                 dhpzr[k][2] * _g_c(nz - 3) *
                                     (phx[2] * _s11(i, j + rj0, nz - 3) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 3) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 3) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 3)) +
                                 dhpzr[k][1] * _g_c(nz - 2) *
                                     (phx[2] * _s11(i, j + rj0, nz - 2) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 2) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 2) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 2)) +
                                 dhpzr[k][0] * _g_c(nz - 1) *
                                     (phx[2] * _s11(i, j + rj0, nz - 1) +
                                      phx[0] * _s11(i - 2, j + rj0, nz - 1) +
                                      phx[1] * _s11(i - 1, j + rj0, nz - 1) +
                                      phx[3] * _s11(i + 1, j + rj0, nz - 1))) -
            _f2_1(i, j + rj0) *
                (dhpzr[k][8] * _g_c(nz - 9) *
                     (phy[2] * _s12(i, j + rj0, nz - 9) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 9) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 9) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 9)) +
                 dhpzr[k][7] * _g_c(nz - 8) *
                     (phy[2] * _s12(i, j + rj0, nz - 8) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 8) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 8) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 8)) +
                 dhpzr[k][6] * _g_c(nz - 7) *
                     (phy[2] * _s12(i, j + rj0, nz - 7) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 7) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 7) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 7)) +
                 dhpzr[k][5] * _g_c(nz - 6) *
                     (phy[2] * _s12(i, j + rj0, nz - 6) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 6) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 6) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 6)) +
                 dhpzr[k][4] * _g_c(nz - 5) *
                     (phy[2] * _s12(i, j + rj0, nz - 5) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 5) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 5) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 5)) +
                 dhpzr[k][3] * _g_c(nz - 4) *
                     (phy[2] * _s12(i, j + rj0, nz - 4) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 4) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 4) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 4)) +
                 dhpzr[k][2] * _g_c(nz - 3) *
                     (phy[2] * _s12(i, j + rj0, nz - 3) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 3) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 3) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 3)) +
                 dhpzr[k][1] * _g_c(nz - 2) *
                     (phy[2] * _s12(i, j + rj0, nz - 2) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 2) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 2) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 2)) +
                 dhpzr[k][0] * _g_c(nz - 1) *
                     (phy[2] * _s12(i, j + rj0, nz - 1) +
                      phy[0] * _s12(i, j + rj0 - 2, nz - 1) +
                      phy[1] * _s12(i, j + rj0 - 1, nz - 1) +
                      phy[3] * _s12(i, j + rj0 + 1, nz - 1))))) *
      f_dcrj;
  _buf_u2(i, j, nz - 1 - k) =
      (a * _u2(i, j + rj0, nz - 1 - k) +
       Ai2 *
           (dhzr[k][7] * _s23(i, j + rj0, nz - 8) +
            dhzr[k][6] * _s23(i, j + rj0, nz - 7) +
            dhzr[k][5] * _s23(i, j + rj0, nz - 6) +
            dhzr[k][4] * _s23(i, j + rj0, nz - 5) +
            dhzr[k][3] * _s23(i, j + rj0, nz - 4) +
            dhzr[k][2] * _s23(i, j + rj0, nz - 3) +
            dhzr[k][1] * _s23(i, j + rj0, nz - 2) +
            dhzr[k][0] * _s23(i, j + rj0, nz - 1) +
            dx[1] * _f(i, j + rj0) * _g3_c(nz - 1 - k) *
                _s12(i, j + rj0, nz - 1 - k) +
            dx[0] * _f(i - 1, j + rj0) * _g3_c(nz - 1 - k) *
                _s12(i - 1, j + rj0, nz - 1 - k) +
            dx[2] * _f(i + 1, j + rj0) * _g3_c(nz - 1 - k) *
                _s12(i + 1, j + rj0, nz - 1 - k) +
            dx[3] * _f(i + 2, j + rj0) * _g3_c(nz - 1 - k) *
                _s12(i + 2, j + rj0, nz - 1 - k) +
            dy[1] * _f_c(i, j + rj0) * _g3_c(nz - 1 - k) *
                _s22(i, j + rj0, nz - 1 - k) +
            dy[0] * _f_c(i, j + rj0 - 1) * _g3_c(nz - 1 - k) *
                _s22(i, j + rj0 - 1, nz - 1 - k) +
            dy[2] * _f_c(i, j + rj0 + 1) * _g3_c(nz - 1 - k) *
                _s22(i, j + rj0 + 1, nz - 1 - k) +
            dy[3] * _f_c(i, j + rj0 + 2) * _g3_c(nz - 1 - k) *
                _s22(i, j + rj0 + 2, nz - 1 - k) -
            _f1_2(i, j + rj0) * (dhpzr[k][8] * _g_c(nz - 9) *
                                     (px[1] * _s12(i, j + rj0, nz - 9) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 9) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 9) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 9)) +
                                 dhpzr[k][7] * _g_c(nz - 8) *
                                     (px[1] * _s12(i, j + rj0, nz - 8) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 8) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 8) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 8)) +
                                 dhpzr[k][6] * _g_c(nz - 7) *
                                     (px[1] * _s12(i, j + rj0, nz - 7) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 7) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 7) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 7)) +
                                 dhpzr[k][5] * _g_c(nz - 6) *
                                     (px[1] * _s12(i, j + rj0, nz - 6) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 6) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 6) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 6)) +
                                 dhpzr[k][4] * _g_c(nz - 5) *
                                     (px[1] * _s12(i, j + rj0, nz - 5) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 5) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 5) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 5)) +
                                 dhpzr[k][3] * _g_c(nz - 4) *
                                     (px[1] * _s12(i, j + rj0, nz - 4) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 4) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 4) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 4)) +
                                 dhpzr[k][2] * _g_c(nz - 3) *
                                     (px[1] * _s12(i, j + rj0, nz - 3) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 3) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 3) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 3)) +
                                 dhpzr[k][1] * _g_c(nz - 2) *
                                     (px[1] * _s12(i, j + rj0, nz - 2) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 2) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 2) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 2)) +
                                 dhpzr[k][0] * _g_c(nz - 1) *
                                     (px[1] * _s12(i, j + rj0, nz - 1) +
                                      px[0] * _s12(i - 1, j + rj0, nz - 1) +
                                      px[2] * _s12(i + 1, j + rj0, nz - 1) +
                                      px[3] * _s12(i + 2, j + rj0, nz - 1))) -
            _f2_2(i, j + rj0) * (dhpzr[k][8] * _g_c(nz - 9) *
                                     (py[1] * _s22(i, j + rj0, nz - 9) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 9) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 9) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 9)) +
                                 dhpzr[k][7] * _g_c(nz - 8) *
                                     (py[1] * _s22(i, j + rj0, nz - 8) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 8) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 8) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 8)) +
                                 dhpzr[k][6] * _g_c(nz - 7) *
                                     (py[1] * _s22(i, j + rj0, nz - 7) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 7) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 7) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 7)) +
                                 dhpzr[k][5] * _g_c(nz - 6) *
                                     (py[1] * _s22(i, j + rj0, nz - 6) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 6) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 6) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 6)) +
                                 dhpzr[k][4] * _g_c(nz - 5) *
                                     (py[1] * _s22(i, j + rj0, nz - 5) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 5) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 5) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 5)) +
                                 dhpzr[k][3] * _g_c(nz - 4) *
                                     (py[1] * _s22(i, j + rj0, nz - 4) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 4) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 4) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 4)) +
                                 dhpzr[k][2] * _g_c(nz - 3) *
                                     (py[1] * _s22(i, j + rj0, nz - 3) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 3) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 3) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 3)) +
                                 dhpzr[k][1] * _g_c(nz - 2) *
                                     (py[1] * _s22(i, j + rj0, nz - 2) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 2) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 2) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 2)) +
                                 dhpzr[k][0] * _g_c(nz - 1) *
                                     (py[1] * _s22(i, j + rj0, nz - 1) +
                                      py[0] * _s22(i, j + rj0 - 1, nz - 1) +
                                      py[2] * _s22(i, j + rj0 + 1, nz - 1) +
                                      py[3] * _s22(i, j + rj0 + 2, nz - 1))))) *
      f_dcrj;
  _buf_u3(i, j, nz - 1 - k) =
      (a * _u3(i, j + rj0, nz - 1 - k) +
       Ai3 * (dhy[2] * _f_2(i, j + rj0) * _g3(nz - 1 - k) *
                  _s23(i, j + rj0, nz - 1 - k) +
              dhy[0] * _f_2(i, j + rj0 - 2) * _g3(nz - 1 - k) *
                  _s23(i, j + rj0 - 2, nz - 1 - k) +
              dhy[1] * _f_2(i, j + rj0 - 1) * _g3(nz - 1 - k) *
                  _s23(i, j + rj0 - 1, nz - 1 - k) +
              dhy[3] * _f_2(i, j + rj0 + 1) * _g3(nz - 1 - k) *
                  _s23(i, j + rj0 + 1, nz - 1 - k) +
              dx[1] * _f_1(i, j + rj0) * _g3(nz - 1 - k) *
                  _s13(i, j + rj0, nz - 1 - k) +
              dx[0] * _f_1(i - 1, j + rj0) * _g3(nz - 1 - k) *
                  _s13(i - 1, j + rj0, nz - 1 - k) +
              dx[2] * _f_1(i + 1, j + rj0) * _g3(nz - 1 - k) *
                  _s13(i + 1, j + rj0, nz - 1 - k) +
              dx[3] * _f_1(i + 2, j + rj0) * _g3(nz - 1 - k) *
                  _s13(i + 2, j + rj0, nz - 1 - k) +
              dzr[k][6] * _s33(i, j + rj0, nz - 7) +
              dzr[k][5] * _s33(i, j + rj0, nz - 6) +
              dzr[k][4] * _s33(i, j + rj0, nz - 5) +
              dzr[k][3] * _s33(i, j + rj0, nz - 4) +
              dzr[k][2] * _s33(i, j + rj0, nz - 3) +
              dzr[k][1] * _s33(i, j + rj0, nz - 2) +
              dzr[k][0] * _s33(i, j + rj0, nz - 1) -
              _f1_c(i, j + rj0) * (dphzr[k][8] * _g(nz - 9) *
                                       (px[1] * _s13(i, j + rj0, nz - 9) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 9) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 9) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 9)) +
                                   dphzr[k][7] * _g(nz - 8) *
                                       (px[1] * _s13(i, j + rj0, nz - 8) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 8) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 8) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 8)) +
                                   dphzr[k][6] * _g(nz - 7) *
                                       (px[1] * _s13(i, j + rj0, nz - 7) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 7) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 7) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 7)) +
                                   dphzr[k][5] * _g(nz - 6) *
                                       (px[1] * _s13(i, j + rj0, nz - 6) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 6) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 6) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 6)) +
                                   dphzr[k][4] * _g(nz - 5) *
                                       (px[1] * _s13(i, j + rj0, nz - 5) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 5) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 5) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 5)) +
                                   dphzr[k][3] * _g(nz - 4) *
                                       (px[1] * _s13(i, j + rj0, nz - 4) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 4) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 4) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 4)) +
                                   dphzr[k][2] * _g(nz - 3) *
                                       (px[1] * _s13(i, j + rj0, nz - 3) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 3) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 3) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 3)) +
                                   dphzr[k][1] * _g(nz - 2) *
                                       (px[1] * _s13(i, j + rj0, nz - 2) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 2) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 2) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 2)) +
                                   dphzr[k][0] * _g(nz - 1) *
                                       (px[1] * _s13(i, j + rj0, nz - 1) +
                                        px[0] * _s13(i - 1, j + rj0, nz - 1) +
                                        px[2] * _s13(i + 1, j + rj0, nz - 1) +
                                        px[3] * _s13(i + 2, j + rj0, nz - 1))) -
              _f2_c(i, j + rj0) *
                  (dphzr[k][8] * _g(nz - 9) *
                       (phy[2] * _s23(i, j + rj0, nz - 9) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 9) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 9) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 9)) +
                   dphzr[k][7] * _g(nz - 8) *
                       (phy[2] * _s23(i, j + rj0, nz - 8) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 8) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 8) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 8)) +
                   dphzr[k][6] * _g(nz - 7) *
                       (phy[2] * _s23(i, j + rj0, nz - 7) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 7) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 7) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 7)) +
                   dphzr[k][5] * _g(nz - 6) *
                       (phy[2] * _s23(i, j + rj0, nz - 6) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 6) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 6) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 6)) +
                   dphzr[k][4] * _g(nz - 5) *
                       (phy[2] * _s23(i, j + rj0, nz - 5) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 5) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 5) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 5)) +
                   dphzr[k][3] * _g(nz - 4) *
                       (phy[2] * _s23(i, j + rj0, nz - 4) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 4) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 4) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 4)) +
                   dphzr[k][2] * _g(nz - 3) *
                       (phy[2] * _s23(i, j + rj0, nz - 3) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 3) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 3) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 3)) +
                   dphzr[k][1] * _g(nz - 2) *
                       (phy[2] * _s23(i, j + rj0, nz - 2) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 2) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 2) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 2)) +
                   dphzr[k][0] * _g(nz - 1) *
                       (phy[2] * _s23(i, j + rj0, nz - 1) +
                        phy[0] * _s23(i, j + rj0 - 2, nz - 1) +
                        phy[1] * _s23(i, j + rj0 - 1, nz - 1) +
                        phy[3] * _s23(i, j + rj0 + 1, nz - 1))))) *
      f_dcrj;
#undef _rho
#undef _f_1
#undef _g3_c
#undef _f_2
#undef _f_c
#undef _g3
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _f
#undef _s13
#undef _u1
#undef _s11
#undef _f2_1
#undef _f1_1
#undef _s12
#undef _g_c
#undef _s23
#undef _f2_2
#undef _s22
#undef _f1_2
#undef _u2
#undef _g
#undef _s33
#undef _f2_c
#undef _f1_c
#undef _u3
#undef _buf_u1
#undef _buf_u2
#undef _buf_u3
}

__global__ void dtopo_str_110(
    float *s11, float *s12, float *s13, float *s22, float *s23, float *s33,
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *lami,
    const float *mui, const float a, const float nu, const int nx, const int ny,
    const int nz, const int bi, const int bj, const int ei, const int ej) {
  const float phzl[6][7] = {
      {0.8338228784688313, 0.1775123316429260, 0.1435067013076542,
       -0.1548419114194114, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.1813404047323969, 1.1246711188154426, -0.2933634518280757,
       -0.0126480717197637, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1331142706282399, 0.7930714675884345, 0.3131998767078508,
       0.0268429263319546, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.0969078556633046, -0.1539344946680898, 0.4486491202844389,
       0.6768738207821733, -0.0684963020618270, 0.0000000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, -0.0625000000000000,
       0.5625000000000000, 0.5625000000000000, -0.0625000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0625000000000000, 0.5625000000000000, 0.5625000000000000,
       -0.0625000000000000}};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dhzl[6][7] = {
      {-1.4511412472637157, 1.8534237417911470, -0.3534237417911469,
       -0.0488587527362844, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.8577143189081458, 0.5731429567244373, 0.4268570432755628,
       -0.1422856810918542, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1674548505882877, -0.4976354482351368, 0.4976354482351368,
       0.1674548505882877, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.1027061113405124, -0.2624541326469860, -0.8288742701021167,
       1.0342864927831414, -0.0456642013745513, 0.0000000000000000,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0416666666666667,
       -1.1250000000000000, 1.1250000000000000, -0.0416666666666667,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0416666666666667, -1.1250000000000000, 1.1250000000000000,
       -0.0416666666666667}};
  const float phdzl[6][9] = {
      {-1.5373923010673116, 1.0330083346742178, 0.6211677623382129,
       0.0454110758451345, -0.1680934225988761, 0.0058985508086226,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.8713921425924011, 0.1273679143938725, 0.9297550647681330,
       -0.1912595577524762, 0.0050469052908678, 0.0004818158920039,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.0563333965151294, -0.3996393739211770, -0.0536007135209481,
       0.5022638816465500, 0.0083321572725344, -0.0010225549618299,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.0132930497153990, 0.0706942590708847, -0.5596445380498725,
       -0.1434031863528334, 0.7456356868769503, -0.1028431844156395,
       0.0028540125859095, 0.0000000000000000, 0.0000000000000000},
      {-0.0025849423769932, 0.0492307522105194, -0.0524552477068130,
       -0.5317248489238559, -0.0530169938441241, 0.6816971139746001,
       -0.0937500000000000, 0.0026041666666667, 0.0000000000000000},
      {-0.0009619461344193, -0.0035553215968974, 0.0124936029037323,
       0.0773639466787397, -0.6736586580761996, -0.0002232904416222,
       0.6796875000000000, -0.0937500000000000, 0.0026041666666667}};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dzl[6][8] = {
      {-1.7779989465546748, 1.3337480247900155, 0.7775013168066564,
       -0.3332503950419969, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {-0.4410217341392059, -0.1730842484889890, 0.4487228323259926,
       0.1653831503022022, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.1798793213882701, -0.2757257254150788, -0.9597948548284453,
       1.1171892610431817, -0.0615480021879277, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0153911381507088, 0.0568851455503591, -0.1998976464597171,
       -0.8628231468598346, 1.0285385292191949, -0.0380940196007109,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0416666666666667, -1.1250000000000000, 1.1250000000000000,
       -0.0416666666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0416666666666667, -1.1250000000000000,
       1.1250000000000000, -0.0416666666666667}};
  const float pdhzl[6][9] = {
      {-1.5886075042755416, 2.2801810182668110, -0.8088980291471827,
       0.1316830205960989, -0.0143585054401857, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {-0.4823226655921296, -0.0574614517751294, 0.5663203488781653,
       -0.0309656800624243, 0.0044294485515179, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0174954311279016, -0.4325508330649350, -0.3111668377093504,
       0.8538512002386446, -0.1314757107290064, 0.0038467501367455,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.1277481742492071, -0.2574468839590017, -0.4155794781917712,
       0.0115571196122084, 0.6170517361659126, -0.0857115441015996,
       0.0023808762250444, 0.0000000000000000, 0.0000000000000000},
      {-0.0064191319587820, 0.0164033832904366, 0.0752421418813823,
       -0.6740179057989464, 0.0002498459192428, 0.6796875000000000,
       -0.0937500000000000, 0.0026041666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, -0.0026041666666667,
       0.0937500000000000, -0.6796875000000000, -0.0000000000000000,
       0.6796875000000000, -0.0937500000000000, 0.0026041666666667}};
  const int i = threadIdx.x + blockIdx.x * blockDim.x + bi;
  if (i >= ngsl + nx)
    return;
  if (i >= ei)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ngsl + ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= 6)
    return;
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _lami(i, j, k)                                                         \
  lami[(k) + align +                                                           \
       (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +             \
       (2 * align + nz) * ((j) + ngsl + 2)]
#define _mui(i, j, k)                                                          \
  mui[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
  float Jii = _f_c(i, j) * _g3_c(k);
  Jii = 1.0 * 1.0 / Jii;
  float J12i = _f(i, j) * _g3_c(k);
  J12i = 1.0 * 1.0 / J12i;
  float J13i = _f_1(i, j) * _g3(k);
  J13i = 1.0 * 1.0 / J13i;
  float J23i = _f_2(i, j) * _g3(k);
  J23i = 1.0 * 1.0 / J23i;
  float lam =
      nu * 1.0 /
      (phzl[k][0] *
           (phy[2] * (px[1] * _lami(i, j, 0) + px[0] * _lami(i - 1, j, 0) +
                      px[2] * _lami(i + 1, j, 0) + px[3] * _lami(i + 2, j, 0)) +
            phy[0] *
                (px[1] * _lami(i, j - 2, 0) + px[0] * _lami(i - 1, j - 2, 0) +
                 px[2] * _lami(i + 1, j - 2, 0) +
                 px[3] * _lami(i + 2, j - 2, 0)) +
            phy[1] *
                (px[1] * _lami(i, j - 1, 0) + px[0] * _lami(i - 1, j - 1, 0) +
                 px[2] * _lami(i + 1, j - 1, 0) +
                 px[3] * _lami(i + 2, j - 1, 0)) +
            phy[3] *
                (px[1] * _lami(i, j + 1, 0) + px[0] * _lami(i - 1, j + 1, 0) +
                 px[2] * _lami(i + 1, j + 1, 0) +
                 px[3] * _lami(i + 2, j + 1, 0))) +
       phzl[k][1] *
           (phy[2] * (px[1] * _lami(i, j, 1) + px[0] * _lami(i - 1, j, 1) +
                      px[2] * _lami(i + 1, j, 1) + px[3] * _lami(i + 2, j, 1)) +
            phy[0] *
                (px[1] * _lami(i, j - 2, 1) + px[0] * _lami(i - 1, j - 2, 1) +
                 px[2] * _lami(i + 1, j - 2, 1) +
                 px[3] * _lami(i + 2, j - 2, 1)) +
            phy[1] *
                (px[1] * _lami(i, j - 1, 1) + px[0] * _lami(i - 1, j - 1, 1) +
                 px[2] * _lami(i + 1, j - 1, 1) +
                 px[3] * _lami(i + 2, j - 1, 1)) +
            phy[3] *
                (px[1] * _lami(i, j + 1, 1) + px[0] * _lami(i - 1, j + 1, 1) +
                 px[2] * _lami(i + 1, j + 1, 1) +
                 px[3] * _lami(i + 2, j + 1, 1))) +
       phzl[k][2] *
           (phy[2] * (px[1] * _lami(i, j, 2) + px[0] * _lami(i - 1, j, 2) +
                      px[2] * _lami(i + 1, j, 2) + px[3] * _lami(i + 2, j, 2)) +
            phy[0] *
                (px[1] * _lami(i, j - 2, 2) + px[0] * _lami(i - 1, j - 2, 2) +
                 px[2] * _lami(i + 1, j - 2, 2) +
                 px[3] * _lami(i + 2, j - 2, 2)) +
            phy[1] *
                (px[1] * _lami(i, j - 1, 2) + px[0] * _lami(i - 1, j - 1, 2) +
                 px[2] * _lami(i + 1, j - 1, 2) +
                 px[3] * _lami(i + 2, j - 1, 2)) +
            phy[3] *
                (px[1] * _lami(i, j + 1, 2) + px[0] * _lami(i - 1, j + 1, 2) +
                 px[2] * _lami(i + 1, j + 1, 2) +
                 px[3] * _lami(i + 2, j + 1, 2))) +
       phzl[k][3] *
           (phy[2] * (px[1] * _lami(i, j, 3) + px[0] * _lami(i - 1, j, 3) +
                      px[2] * _lami(i + 1, j, 3) + px[3] * _lami(i + 2, j, 3)) +
            phy[0] *
                (px[1] * _lami(i, j - 2, 3) + px[0] * _lami(i - 1, j - 2, 3) +
                 px[2] * _lami(i + 1, j - 2, 3) +
                 px[3] * _lami(i + 2, j - 2, 3)) +
            phy[1] *
                (px[1] * _lami(i, j - 1, 3) + px[0] * _lami(i - 1, j - 1, 3) +
                 px[2] * _lami(i + 1, j - 1, 3) +
                 px[3] * _lami(i + 2, j - 1, 3)) +
            phy[3] *
                (px[1] * _lami(i, j + 1, 3) + px[0] * _lami(i - 1, j + 1, 3) +
                 px[2] * _lami(i + 1, j + 1, 3) +
                 px[3] * _lami(i + 2, j + 1, 3))) +
       phzl[k][4] *
           (phy[2] * (px[1] * _lami(i, j, 4) + px[0] * _lami(i - 1, j, 4) +
                      px[2] * _lami(i + 1, j, 4) + px[3] * _lami(i + 2, j, 4)) +
            phy[0] *
                (px[1] * _lami(i, j - 2, 4) + px[0] * _lami(i - 1, j - 2, 4) +
                 px[2] * _lami(i + 1, j - 2, 4) +
                 px[3] * _lami(i + 2, j - 2, 4)) +
            phy[1] *
                (px[1] * _lami(i, j - 1, 4) + px[0] * _lami(i - 1, j - 1, 4) +
                 px[2] * _lami(i + 1, j - 1, 4) +
                 px[3] * _lami(i + 2, j - 1, 4)) +
            phy[3] *
                (px[1] * _lami(i, j + 1, 4) + px[0] * _lami(i - 1, j + 1, 4) +
                 px[2] * _lami(i + 1, j + 1, 4) +
                 px[3] * _lami(i + 2, j + 1, 4))) +
       phzl[k][5] *
           (phy[2] * (px[1] * _lami(i, j, 5) + px[0] * _lami(i - 1, j, 5) +
                      px[2] * _lami(i + 1, j, 5) + px[3] * _lami(i + 2, j, 5)) +
            phy[0] *
                (px[1] * _lami(i, j - 2, 5) + px[0] * _lami(i - 1, j - 2, 5) +
                 px[2] * _lami(i + 1, j - 2, 5) +
                 px[3] * _lami(i + 2, j - 2, 5)) +
            phy[1] *
                (px[1] * _lami(i, j - 1, 5) + px[0] * _lami(i - 1, j - 1, 5) +
                 px[2] * _lami(i + 1, j - 1, 5) +
                 px[3] * _lami(i + 2, j - 1, 5)) +
            phy[3] *
                (px[1] * _lami(i, j + 1, 5) + px[0] * _lami(i - 1, j + 1, 5) +
                 px[2] * _lami(i + 1, j + 1, 5) +
                 px[3] * _lami(i + 2, j + 1, 5))) +
       phzl[k][6] *
           (phy[2] * (px[1] * _lami(i, j, 6) + px[0] * _lami(i - 1, j, 6) +
                      px[2] * _lami(i + 1, j, 6) + px[3] * _lami(i + 2, j, 6)) +
            phy[0] *
                (px[1] * _lami(i, j - 2, 6) + px[0] * _lami(i - 1, j - 2, 6) +
                 px[2] * _lami(i + 1, j - 2, 6) +
                 px[3] * _lami(i + 2, j - 2, 6)) +
            phy[1] *
                (px[1] * _lami(i, j - 1, 6) + px[0] * _lami(i - 1, j - 1, 6) +
                 px[2] * _lami(i + 1, j - 1, 6) +
                 px[3] * _lami(i + 2, j - 1, 6)) +
            phy[3] *
                (px[1] * _lami(i, j + 1, 6) + px[0] * _lami(i - 1, j + 1, 6) +
                 px[2] * _lami(i + 1, j + 1, 6) +
                 px[3] * _lami(i + 2, j + 1, 6))));
  float twomu =
      2 * nu * 1.0 /
      (phzl[k][0] *
           (phy[2] * (px[1] * _mui(i, j, 0) + px[0] * _mui(i - 1, j, 0) +
                      px[2] * _mui(i + 1, j, 0) + px[3] * _mui(i + 2, j, 0)) +
            phy[0] *
                (px[1] * _mui(i, j - 2, 0) + px[0] * _mui(i - 1, j - 2, 0) +
                 px[2] * _mui(i + 1, j - 2, 0) +
                 px[3] * _mui(i + 2, j - 2, 0)) +
            phy[1] *
                (px[1] * _mui(i, j - 1, 0) + px[0] * _mui(i - 1, j - 1, 0) +
                 px[2] * _mui(i + 1, j - 1, 0) +
                 px[3] * _mui(i + 2, j - 1, 0)) +
            phy[3] *
                (px[1] * _mui(i, j + 1, 0) + px[0] * _mui(i - 1, j + 1, 0) +
                 px[2] * _mui(i + 1, j + 1, 0) +
                 px[3] * _mui(i + 2, j + 1, 0))) +
       phzl[k][1] *
           (phy[2] * (px[1] * _mui(i, j, 1) + px[0] * _mui(i - 1, j, 1) +
                      px[2] * _mui(i + 1, j, 1) + px[3] * _mui(i + 2, j, 1)) +
            phy[0] *
                (px[1] * _mui(i, j - 2, 1) + px[0] * _mui(i - 1, j - 2, 1) +
                 px[2] * _mui(i + 1, j - 2, 1) +
                 px[3] * _mui(i + 2, j - 2, 1)) +
            phy[1] *
                (px[1] * _mui(i, j - 1, 1) + px[0] * _mui(i - 1, j - 1, 1) +
                 px[2] * _mui(i + 1, j - 1, 1) +
                 px[3] * _mui(i + 2, j - 1, 1)) +
            phy[3] *
                (px[1] * _mui(i, j + 1, 1) + px[0] * _mui(i - 1, j + 1, 1) +
                 px[2] * _mui(i + 1, j + 1, 1) +
                 px[3] * _mui(i + 2, j + 1, 1))) +
       phzl[k][2] *
           (phy[2] * (px[1] * _mui(i, j, 2) + px[0] * _mui(i - 1, j, 2) +
                      px[2] * _mui(i + 1, j, 2) + px[3] * _mui(i + 2, j, 2)) +
            phy[0] *
                (px[1] * _mui(i, j - 2, 2) + px[0] * _mui(i - 1, j - 2, 2) +
                 px[2] * _mui(i + 1, j - 2, 2) +
                 px[3] * _mui(i + 2, j - 2, 2)) +
            phy[1] *
                (px[1] * _mui(i, j - 1, 2) + px[0] * _mui(i - 1, j - 1, 2) +
                 px[2] * _mui(i + 1, j - 1, 2) +
                 px[3] * _mui(i + 2, j - 1, 2)) +
            phy[3] *
                (px[1] * _mui(i, j + 1, 2) + px[0] * _mui(i - 1, j + 1, 2) +
                 px[2] * _mui(i + 1, j + 1, 2) +
                 px[3] * _mui(i + 2, j + 1, 2))) +
       phzl[k][3] *
           (phy[2] * (px[1] * _mui(i, j, 3) + px[0] * _mui(i - 1, j, 3) +
                      px[2] * _mui(i + 1, j, 3) + px[3] * _mui(i + 2, j, 3)) +
            phy[0] *
                (px[1] * _mui(i, j - 2, 3) + px[0] * _mui(i - 1, j - 2, 3) +
                 px[2] * _mui(i + 1, j - 2, 3) +
                 px[3] * _mui(i + 2, j - 2, 3)) +
            phy[1] *
                (px[1] * _mui(i, j - 1, 3) + px[0] * _mui(i - 1, j - 1, 3) +
                 px[2] * _mui(i + 1, j - 1, 3) +
                 px[3] * _mui(i + 2, j - 1, 3)) +
            phy[3] *
                (px[1] * _mui(i, j + 1, 3) + px[0] * _mui(i - 1, j + 1, 3) +
                 px[2] * _mui(i + 1, j + 1, 3) +
                 px[3] * _mui(i + 2, j + 1, 3))) +
       phzl[k][4] *
           (phy[2] * (px[1] * _mui(i, j, 4) + px[0] * _mui(i - 1, j, 4) +
                      px[2] * _mui(i + 1, j, 4) + px[3] * _mui(i + 2, j, 4)) +
            phy[0] *
                (px[1] * _mui(i, j - 2, 4) + px[0] * _mui(i - 1, j - 2, 4) +
                 px[2] * _mui(i + 1, j - 2, 4) +
                 px[3] * _mui(i + 2, j - 2, 4)) +
            phy[1] *
                (px[1] * _mui(i, j - 1, 4) + px[0] * _mui(i - 1, j - 1, 4) +
                 px[2] * _mui(i + 1, j - 1, 4) +
                 px[3] * _mui(i + 2, j - 1, 4)) +
            phy[3] *
                (px[1] * _mui(i, j + 1, 4) + px[0] * _mui(i - 1, j + 1, 4) +
                 px[2] * _mui(i + 1, j + 1, 4) +
                 px[3] * _mui(i + 2, j + 1, 4))) +
       phzl[k][5] *
           (phy[2] * (px[1] * _mui(i, j, 5) + px[0] * _mui(i - 1, j, 5) +
                      px[2] * _mui(i + 1, j, 5) + px[3] * _mui(i + 2, j, 5)) +
            phy[0] *
                (px[1] * _mui(i, j - 2, 5) + px[0] * _mui(i - 1, j - 2, 5) +
                 px[2] * _mui(i + 1, j - 2, 5) +
                 px[3] * _mui(i + 2, j - 2, 5)) +
            phy[1] *
                (px[1] * _mui(i, j - 1, 5) + px[0] * _mui(i - 1, j - 1, 5) +
                 px[2] * _mui(i + 1, j - 1, 5) +
                 px[3] * _mui(i + 2, j - 1, 5)) +
            phy[3] *
                (px[1] * _mui(i, j + 1, 5) + px[0] * _mui(i - 1, j + 1, 5) +
                 px[2] * _mui(i + 1, j + 1, 5) +
                 px[3] * _mui(i + 2, j + 1, 5))) +
       phzl[k][6] *
           (phy[2] * (px[1] * _mui(i, j, 6) + px[0] * _mui(i - 1, j, 6) +
                      px[2] * _mui(i + 1, j, 6) + px[3] * _mui(i + 2, j, 6)) +
            phy[0] *
                (px[1] * _mui(i, j - 2, 6) + px[0] * _mui(i - 1, j - 2, 6) +
                 px[2] * _mui(i + 1, j - 2, 6) +
                 px[3] * _mui(i + 2, j - 2, 6)) +
            phy[1] *
                (px[1] * _mui(i, j - 1, 6) + px[0] * _mui(i - 1, j - 1, 6) +
                 px[2] * _mui(i + 1, j - 1, 6) +
                 px[3] * _mui(i + 2, j - 1, 6)) +
            phy[3] *
                (px[1] * _mui(i, j + 1, 6) + px[0] * _mui(i - 1, j + 1, 6) +
                 px[2] * _mui(i + 1, j + 1, 6) +
                 px[3] * _mui(i + 2, j + 1, 6))));
  float mu12 = nu * 1.0 /
               (phzl[k][0] * _mui(i, j, 0) + phzl[k][1] * _mui(i, j, 1) +
                phzl[k][2] * _mui(i, j, 2) + phzl[k][3] * _mui(i, j, 3) +
                phzl[k][4] * _mui(i, j, 4) + phzl[k][5] * _mui(i, j, 5) +
                phzl[k][6] * _mui(i, j, 6));
  float mu13 = nu * 1.0 /
               (phy[2] * _mui(i, j, k) + phy[0] * _mui(i, j - 2, k) +
                phy[1] * _mui(i, j - 1, k) + phy[3] * _mui(i, j + 1, k));
  float mu23 = nu * 1.0 /
               (px[1] * _mui(i, j, k) + px[0] * _mui(i - 1, j, k) +
                px[2] * _mui(i + 1, j, k) + px[3] * _mui(i + 2, j, k));
  float div =
      dhy[2] * _u2(i, j, k) + dhy[0] * _u2(i, j - 2, k) +
      dhy[1] * _u2(i, j - 1, k) + dhy[3] * _u2(i, j + 1, k) +
      dx[1] * _u1(i, j, k) + dx[0] * _u1(i - 1, j, k) +
      dx[2] * _u1(i + 1, j, k) + dx[3] * _u1(i + 2, j, k) +
      Jii * (dhzl[k][0] * _u3(i, j, 0) + dhzl[k][1] * _u3(i, j, 1) +
             dhzl[k][2] * _u3(i, j, 2) + dhzl[k][3] * _u3(i, j, 3) +
             dhzl[k][4] * _u3(i, j, 4) + dhzl[k][5] * _u3(i, j, 5) +
             dhzl[k][6] * _u3(i, j, 6)) -
      Jii * _g_c(k) *
          (phy[2] * _f2_2(i, j) *
               (phdzl[k][0] * _u2(i, j, 0) + phdzl[k][1] * _u2(i, j, 1) +
                phdzl[k][2] * _u2(i, j, 2) + phdzl[k][3] * _u2(i, j, 3) +
                phdzl[k][4] * _u2(i, j, 4) + phdzl[k][5] * _u2(i, j, 5) +
                phdzl[k][6] * _u2(i, j, 6) + phdzl[k][7] * _u2(i, j, 7) +
                phdzl[k][8] * _u2(i, j, 8)) +
           phy[0] * _f2_2(i, j - 2) *
               (phdzl[k][0] * _u2(i, j - 2, 0) +
                phdzl[k][1] * _u2(i, j - 2, 1) +
                phdzl[k][2] * _u2(i, j - 2, 2) +
                phdzl[k][3] * _u2(i, j - 2, 3) +
                phdzl[k][4] * _u2(i, j - 2, 4) +
                phdzl[k][5] * _u2(i, j - 2, 5) +
                phdzl[k][6] * _u2(i, j - 2, 6) +
                phdzl[k][7] * _u2(i, j - 2, 7) +
                phdzl[k][8] * _u2(i, j - 2, 8)) +
           phy[1] * _f2_2(i, j - 1) *
               (phdzl[k][0] * _u2(i, j - 1, 0) +
                phdzl[k][1] * _u2(i, j - 1, 1) +
                phdzl[k][2] * _u2(i, j - 1, 2) +
                phdzl[k][3] * _u2(i, j - 1, 3) +
                phdzl[k][4] * _u2(i, j - 1, 4) +
                phdzl[k][5] * _u2(i, j - 1, 5) +
                phdzl[k][6] * _u2(i, j - 1, 6) +
                phdzl[k][7] * _u2(i, j - 1, 7) +
                phdzl[k][8] * _u2(i, j - 1, 8)) +
           phy[3] * _f2_2(i, j + 1) *
               (phdzl[k][0] * _u2(i, j + 1, 0) +
                phdzl[k][1] * _u2(i, j + 1, 1) +
                phdzl[k][2] * _u2(i, j + 1, 2) +
                phdzl[k][3] * _u2(i, j + 1, 3) +
                phdzl[k][4] * _u2(i, j + 1, 4) +
                phdzl[k][5] * _u2(i, j + 1, 5) +
                phdzl[k][6] * _u2(i, j + 1, 6) +
                phdzl[k][7] * _u2(i, j + 1, 7) +
                phdzl[k][8] * _u2(i, j + 1, 8))) -
      Jii * _g_c(k) *
          (px[1] * _f1_1(i, j) *
               (phdzl[k][0] * _u1(i, j, 0) + phdzl[k][1] * _u1(i, j, 1) +
                phdzl[k][2] * _u1(i, j, 2) + phdzl[k][3] * _u1(i, j, 3) +
                phdzl[k][4] * _u1(i, j, 4) + phdzl[k][5] * _u1(i, j, 5) +
                phdzl[k][6] * _u1(i, j, 6) + phdzl[k][7] * _u1(i, j, 7) +
                phdzl[k][8] * _u1(i, j, 8)) +
           px[0] * _f1_1(i - 1, j) *
               (phdzl[k][0] * _u1(i - 1, j, 0) +
                phdzl[k][1] * _u1(i - 1, j, 1) +
                phdzl[k][2] * _u1(i - 1, j, 2) +
                phdzl[k][3] * _u1(i - 1, j, 3) +
                phdzl[k][4] * _u1(i - 1, j, 4) +
                phdzl[k][5] * _u1(i - 1, j, 5) +
                phdzl[k][6] * _u1(i - 1, j, 6) +
                phdzl[k][7] * _u1(i - 1, j, 7) +
                phdzl[k][8] * _u1(i - 1, j, 8)) +
           px[2] * _f1_1(i + 1, j) *
               (phdzl[k][0] * _u1(i + 1, j, 0) +
                phdzl[k][1] * _u1(i + 1, j, 1) +
                phdzl[k][2] * _u1(i + 1, j, 2) +
                phdzl[k][3] * _u1(i + 1, j, 3) +
                phdzl[k][4] * _u1(i + 1, j, 4) +
                phdzl[k][5] * _u1(i + 1, j, 5) +
                phdzl[k][6] * _u1(i + 1, j, 6) +
                phdzl[k][7] * _u1(i + 1, j, 7) +
                phdzl[k][8] * _u1(i + 1, j, 8)) +
           px[3] * _f1_1(i + 2, j) *
               (phdzl[k][0] * _u1(i + 2, j, 0) +
                phdzl[k][1] * _u1(i + 2, j, 1) +
                phdzl[k][2] * _u1(i + 2, j, 2) +
                phdzl[k][3] * _u1(i + 2, j, 3) +
                phdzl[k][4] * _u1(i + 2, j, 4) +
                phdzl[k][5] * _u1(i + 2, j, 5) +
                phdzl[k][6] * _u1(i + 2, j, 6) +
                phdzl[k][7] * _u1(i + 2, j, 7) +
                phdzl[k][8] * _u1(i + 2, j, 8)));
  float f_dcrj = _dcrjx(i) * _dcrjy(j) * _dcrjz(k);
  _s11(i, j, k) =
      (a * _s11(i, j, k) + lam * div +
       twomu * (dx[1] * _u1(i, j, k) + dx[0] * _u1(i - 1, j, k) +
                dx[2] * _u1(i + 1, j, k) + dx[3] * _u1(i + 2, j, k)) -
       twomu * Jii * _g_c(k) *
           (px[1] * _f1_1(i, j) *
                (phdzl[k][0] * _u1(i, j, 0) + phdzl[k][1] * _u1(i, j, 1) +
                 phdzl[k][2] * _u1(i, j, 2) + phdzl[k][3] * _u1(i, j, 3) +
                 phdzl[k][4] * _u1(i, j, 4) + phdzl[k][5] * _u1(i, j, 5) +
                 phdzl[k][6] * _u1(i, j, 6) + phdzl[k][7] * _u1(i, j, 7) +
                 phdzl[k][8] * _u1(i, j, 8)) +
            px[0] * _f1_1(i - 1, j) *
                (phdzl[k][0] * _u1(i - 1, j, 0) +
                 phdzl[k][1] * _u1(i - 1, j, 1) +
                 phdzl[k][2] * _u1(i - 1, j, 2) +
                 phdzl[k][3] * _u1(i - 1, j, 3) +
                 phdzl[k][4] * _u1(i - 1, j, 4) +
                 phdzl[k][5] * _u1(i - 1, j, 5) +
                 phdzl[k][6] * _u1(i - 1, j, 6) +
                 phdzl[k][7] * _u1(i - 1, j, 7) +
                 phdzl[k][8] * _u1(i - 1, j, 8)) +
            px[2] * _f1_1(i + 1, j) *
                (phdzl[k][0] * _u1(i + 1, j, 0) +
                 phdzl[k][1] * _u1(i + 1, j, 1) +
                 phdzl[k][2] * _u1(i + 1, j, 2) +
                 phdzl[k][3] * _u1(i + 1, j, 3) +
                 phdzl[k][4] * _u1(i + 1, j, 4) +
                 phdzl[k][5] * _u1(i + 1, j, 5) +
                 phdzl[k][6] * _u1(i + 1, j, 6) +
                 phdzl[k][7] * _u1(i + 1, j, 7) +
                 phdzl[k][8] * _u1(i + 1, j, 8)) +
            px[3] * _f1_1(i + 2, j) *
                (phdzl[k][0] * _u1(i + 2, j, 0) +
                 phdzl[k][1] * _u1(i + 2, j, 1) +
                 phdzl[k][2] * _u1(i + 2, j, 2) +
                 phdzl[k][3] * _u1(i + 2, j, 3) +
                 phdzl[k][4] * _u1(i + 2, j, 4) +
                 phdzl[k][5] * _u1(i + 2, j, 5) +
                 phdzl[k][6] * _u1(i + 2, j, 6) +
                 phdzl[k][7] * _u1(i + 2, j, 7) +
                 phdzl[k][8] * _u1(i + 2, j, 8)))) *
      f_dcrj;
  _s22(i, j, k) =
      (a * _s22(i, j, k) + lam * div +
       twomu * (dhy[2] * _u2(i, j, k) + dhy[0] * _u2(i, j - 2, k) +
                dhy[1] * _u2(i, j - 1, k) + dhy[3] * _u2(i, j + 1, k)) -
       twomu * Jii * _g_c(k) *
           (phy[2] * _f2_2(i, j) *
                (phdzl[k][0] * _u2(i, j, 0) + phdzl[k][1] * _u2(i, j, 1) +
                 phdzl[k][2] * _u2(i, j, 2) + phdzl[k][3] * _u2(i, j, 3) +
                 phdzl[k][4] * _u2(i, j, 4) + phdzl[k][5] * _u2(i, j, 5) +
                 phdzl[k][6] * _u2(i, j, 6) + phdzl[k][7] * _u2(i, j, 7) +
                 phdzl[k][8] * _u2(i, j, 8)) +
            phy[0] * _f2_2(i, j - 2) *
                (phdzl[k][0] * _u2(i, j - 2, 0) +
                 phdzl[k][1] * _u2(i, j - 2, 1) +
                 phdzl[k][2] * _u2(i, j - 2, 2) +
                 phdzl[k][3] * _u2(i, j - 2, 3) +
                 phdzl[k][4] * _u2(i, j - 2, 4) +
                 phdzl[k][5] * _u2(i, j - 2, 5) +
                 phdzl[k][6] * _u2(i, j - 2, 6) +
                 phdzl[k][7] * _u2(i, j - 2, 7) +
                 phdzl[k][8] * _u2(i, j - 2, 8)) +
            phy[1] * _f2_2(i, j - 1) *
                (phdzl[k][0] * _u2(i, j - 1, 0) +
                 phdzl[k][1] * _u2(i, j - 1, 1) +
                 phdzl[k][2] * _u2(i, j - 1, 2) +
                 phdzl[k][3] * _u2(i, j - 1, 3) +
                 phdzl[k][4] * _u2(i, j - 1, 4) +
                 phdzl[k][5] * _u2(i, j - 1, 5) +
                 phdzl[k][6] * _u2(i, j - 1, 6) +
                 phdzl[k][7] * _u2(i, j - 1, 7) +
                 phdzl[k][8] * _u2(i, j - 1, 8)) +
            phy[3] * _f2_2(i, j + 1) *
                (phdzl[k][0] * _u2(i, j + 1, 0) +
                 phdzl[k][1] * _u2(i, j + 1, 1) +
                 phdzl[k][2] * _u2(i, j + 1, 2) +
                 phdzl[k][3] * _u2(i, j + 1, 3) +
                 phdzl[k][4] * _u2(i, j + 1, 4) +
                 phdzl[k][5] * _u2(i, j + 1, 5) +
                 phdzl[k][6] * _u2(i, j + 1, 6) +
                 phdzl[k][7] * _u2(i, j + 1, 7) +
                 phdzl[k][8] * _u2(i, j + 1, 8)))) *
      f_dcrj;
  _s33(i, j, k) = (a * _s33(i, j, k) + lam * div +
                   twomu * Jii *
                       (dhzl[k][0] * _u3(i, j, 0) + dhzl[k][1] * _u3(i, j, 1) +
                        dhzl[k][2] * _u3(i, j, 2) + dhzl[k][3] * _u3(i, j, 3) +
                        dhzl[k][4] * _u3(i, j, 4) + dhzl[k][5] * _u3(i, j, 5) +
                        dhzl[k][6] * _u3(i, j, 6))) *
                  f_dcrj;
  _s12(i, j, k) =
      (a * _s12(i, j, k) +
       mu12 *
           (dhx[2] * _u2(i, j, k) + dhx[0] * _u2(i - 2, j, k) +
            dhx[1] * _u2(i - 1, j, k) + dhx[3] * _u2(i + 1, j, k) +
            dy[1] * _u1(i, j, k) + dy[0] * _u1(i, j - 1, k) +
            dy[2] * _u1(i, j + 1, k) + dy[3] * _u1(i, j + 2, k) -
            J12i * _g_c(k) *
                (phx[2] * _f1_2(i, j) *
                     (phdzl[k][0] * _u2(i, j, 0) + phdzl[k][1] * _u2(i, j, 1) +
                      phdzl[k][2] * _u2(i, j, 2) + phdzl[k][3] * _u2(i, j, 3) +
                      phdzl[k][4] * _u2(i, j, 4) + phdzl[k][5] * _u2(i, j, 5) +
                      phdzl[k][6] * _u2(i, j, 6) + phdzl[k][7] * _u2(i, j, 7) +
                      phdzl[k][8] * _u2(i, j, 8)) +
                 phx[0] * _f1_2(i - 2, j) *
                     (phdzl[k][0] * _u2(i - 2, j, 0) +
                      phdzl[k][1] * _u2(i - 2, j, 1) +
                      phdzl[k][2] * _u2(i - 2, j, 2) +
                      phdzl[k][3] * _u2(i - 2, j, 3) +
                      phdzl[k][4] * _u2(i - 2, j, 4) +
                      phdzl[k][5] * _u2(i - 2, j, 5) +
                      phdzl[k][6] * _u2(i - 2, j, 6) +
                      phdzl[k][7] * _u2(i - 2, j, 7) +
                      phdzl[k][8] * _u2(i - 2, j, 8)) +
                 phx[1] * _f1_2(i - 1, j) *
                     (phdzl[k][0] * _u2(i - 1, j, 0) +
                      phdzl[k][1] * _u2(i - 1, j, 1) +
                      phdzl[k][2] * _u2(i - 1, j, 2) +
                      phdzl[k][3] * _u2(i - 1, j, 3) +
                      phdzl[k][4] * _u2(i - 1, j, 4) +
                      phdzl[k][5] * _u2(i - 1, j, 5) +
                      phdzl[k][6] * _u2(i - 1, j, 6) +
                      phdzl[k][7] * _u2(i - 1, j, 7) +
                      phdzl[k][8] * _u2(i - 1, j, 8)) +
                 phx[3] * _f1_2(i + 1, j) *
                     (phdzl[k][0] * _u2(i + 1, j, 0) +
                      phdzl[k][1] * _u2(i + 1, j, 1) +
                      phdzl[k][2] * _u2(i + 1, j, 2) +
                      phdzl[k][3] * _u2(i + 1, j, 3) +
                      phdzl[k][4] * _u2(i + 1, j, 4) +
                      phdzl[k][5] * _u2(i + 1, j, 5) +
                      phdzl[k][6] * _u2(i + 1, j, 6) +
                      phdzl[k][7] * _u2(i + 1, j, 7) +
                      phdzl[k][8] * _u2(i + 1, j, 8))) -
            J12i * _g_c(k) *
                (py[1] * _f2_1(i, j) *
                     (phdzl[k][0] * _u1(i, j, 0) + phdzl[k][1] * _u1(i, j, 1) +
                      phdzl[k][2] * _u1(i, j, 2) + phdzl[k][3] * _u1(i, j, 3) +
                      phdzl[k][4] * _u1(i, j, 4) + phdzl[k][5] * _u1(i, j, 5) +
                      phdzl[k][6] * _u1(i, j, 6) + phdzl[k][7] * _u1(i, j, 7) +
                      phdzl[k][8] * _u1(i, j, 8)) +
                 py[0] * _f2_1(i, j - 1) *
                     (phdzl[k][0] * _u1(i, j - 1, 0) +
                      phdzl[k][1] * _u1(i, j - 1, 1) +
                      phdzl[k][2] * _u1(i, j - 1, 2) +
                      phdzl[k][3] * _u1(i, j - 1, 3) +
                      phdzl[k][4] * _u1(i, j - 1, 4) +
                      phdzl[k][5] * _u1(i, j - 1, 5) +
                      phdzl[k][6] * _u1(i, j - 1, 6) +
                      phdzl[k][7] * _u1(i, j - 1, 7) +
                      phdzl[k][8] * _u1(i, j - 1, 8)) +
                 py[2] * _f2_1(i, j + 1) *
                     (phdzl[k][0] * _u1(i, j + 1, 0) +
                      phdzl[k][1] * _u1(i, j + 1, 1) +
                      phdzl[k][2] * _u1(i, j + 1, 2) +
                      phdzl[k][3] * _u1(i, j + 1, 3) +
                      phdzl[k][4] * _u1(i, j + 1, 4) +
                      phdzl[k][5] * _u1(i, j + 1, 5) +
                      phdzl[k][6] * _u1(i, j + 1, 6) +
                      phdzl[k][7] * _u1(i, j + 1, 7) +
                      phdzl[k][8] * _u1(i, j + 1, 8)) +
                 py[3] * _f2_1(i, j + 2) *
                     (phdzl[k][0] * _u1(i, j + 2, 0) +
                      phdzl[k][1] * _u1(i, j + 2, 1) +
                      phdzl[k][2] * _u1(i, j + 2, 2) +
                      phdzl[k][3] * _u1(i, j + 2, 3) +
                      phdzl[k][4] * _u1(i, j + 2, 4) +
                      phdzl[k][5] * _u1(i, j + 2, 5) +
                      phdzl[k][6] * _u1(i, j + 2, 6) +
                      phdzl[k][7] * _u1(i, j + 2, 7) +
                      phdzl[k][8] * _u1(i, j + 2, 8))))) *
      f_dcrj;
  _s13(i, j, k) =
      (a * _s13(i, j, k) +
       mu13 *
           (dhx[2] * _u3(i, j, k) + dhx[0] * _u3(i - 2, j, k) +
            dhx[1] * _u3(i - 1, j, k) + dhx[3] * _u3(i + 1, j, k) +
            J13i * (dzl[k][0] * _u1(i, j, 0) + dzl[k][1] * _u1(i, j, 1) +
                    dzl[k][2] * _u1(i, j, 2) + dzl[k][3] * _u1(i, j, 3) +
                    dzl[k][4] * _u1(i, j, 4) + dzl[k][5] * _u1(i, j, 5) +
                    dzl[k][6] * _u1(i, j, 6) + dzl[k][7] * _u1(i, j, 7)) -
            J13i * _g(k) *
                (phx[2] * _f1_c(i, j) *
                     (pdhzl[k][0] * _u3(i, j, 0) + pdhzl[k][1] * _u3(i, j, 1) +
                      pdhzl[k][2] * _u3(i, j, 2) + pdhzl[k][3] * _u3(i, j, 3) +
                      pdhzl[k][4] * _u3(i, j, 4) + pdhzl[k][5] * _u3(i, j, 5) +
                      pdhzl[k][6] * _u3(i, j, 6) + pdhzl[k][7] * _u3(i, j, 7) +
                      pdhzl[k][8] * _u3(i, j, 8)) +
                 phx[0] * _f1_c(i - 2, j) *
                     (pdhzl[k][0] * _u3(i - 2, j, 0) +
                      pdhzl[k][1] * _u3(i - 2, j, 1) +
                      pdhzl[k][2] * _u3(i - 2, j, 2) +
                      pdhzl[k][3] * _u3(i - 2, j, 3) +
                      pdhzl[k][4] * _u3(i - 2, j, 4) +
                      pdhzl[k][5] * _u3(i - 2, j, 5) +
                      pdhzl[k][6] * _u3(i - 2, j, 6) +
                      pdhzl[k][7] * _u3(i - 2, j, 7) +
                      pdhzl[k][8] * _u3(i - 2, j, 8)) +
                 phx[1] * _f1_c(i - 1, j) *
                     (pdhzl[k][0] * _u3(i - 1, j, 0) +
                      pdhzl[k][1] * _u3(i - 1, j, 1) +
                      pdhzl[k][2] * _u3(i - 1, j, 2) +
                      pdhzl[k][3] * _u3(i - 1, j, 3) +
                      pdhzl[k][4] * _u3(i - 1, j, 4) +
                      pdhzl[k][5] * _u3(i - 1, j, 5) +
                      pdhzl[k][6] * _u3(i - 1, j, 6) +
                      pdhzl[k][7] * _u3(i - 1, j, 7) +
                      pdhzl[k][8] * _u3(i - 1, j, 8)) +
                 phx[3] * _f1_c(i + 1, j) *
                     (pdhzl[k][0] * _u3(i + 1, j, 0) +
                      pdhzl[k][1] * _u3(i + 1, j, 1) +
                      pdhzl[k][2] * _u3(i + 1, j, 2) +
                      pdhzl[k][3] * _u3(i + 1, j, 3) +
                      pdhzl[k][4] * _u3(i + 1, j, 4) +
                      pdhzl[k][5] * _u3(i + 1, j, 5) +
                      pdhzl[k][6] * _u3(i + 1, j, 6) +
                      pdhzl[k][7] * _u3(i + 1, j, 7) +
                      pdhzl[k][8] * _u3(i + 1, j, 8))))) *
      f_dcrj;
  _s23(i, j, k) =
      (a * _s23(i, j, k) +
       mu23 *
           (dy[1] * _u3(i, j, k) + dy[0] * _u3(i, j - 1, k) +
            dy[2] * _u3(i, j + 1, k) + dy[3] * _u3(i, j + 2, k) +
            J23i * (dzl[k][0] * _u2(i, j, 0) + dzl[k][1] * _u2(i, j, 1) +
                    dzl[k][2] * _u2(i, j, 2) + dzl[k][3] * _u2(i, j, 3) +
                    dzl[k][4] * _u2(i, j, 4) + dzl[k][5] * _u2(i, j, 5) +
                    dzl[k][6] * _u2(i, j, 6) + dzl[k][7] * _u2(i, j, 7)) -
            J23i * _g(k) *
                (py[1] * _f2_c(i, j) *
                     (pdhzl[k][0] * _u3(i, j, 0) + pdhzl[k][1] * _u3(i, j, 1) +
                      pdhzl[k][2] * _u3(i, j, 2) + pdhzl[k][3] * _u3(i, j, 3) +
                      pdhzl[k][4] * _u3(i, j, 4) + pdhzl[k][5] * _u3(i, j, 5) +
                      pdhzl[k][6] * _u3(i, j, 6) + pdhzl[k][7] * _u3(i, j, 7) +
                      pdhzl[k][8] * _u3(i, j, 8)) +
                 py[0] * _f2_c(i, j - 1) *
                     (pdhzl[k][0] * _u3(i, j - 1, 0) +
                      pdhzl[k][1] * _u3(i, j - 1, 1) +
                      pdhzl[k][2] * _u3(i, j - 1, 2) +
                      pdhzl[k][3] * _u3(i, j - 1, 3) +
                      pdhzl[k][4] * _u3(i, j - 1, 4) +
                      pdhzl[k][5] * _u3(i, j - 1, 5) +
                      pdhzl[k][6] * _u3(i, j - 1, 6) +
                      pdhzl[k][7] * _u3(i, j - 1, 7) +
                      pdhzl[k][8] * _u3(i, j - 1, 8)) +
                 py[2] * _f2_c(i, j + 1) *
                     (pdhzl[k][0] * _u3(i, j + 1, 0) +
                      pdhzl[k][1] * _u3(i, j + 1, 1) +
                      pdhzl[k][2] * _u3(i, j + 1, 2) +
                      pdhzl[k][3] * _u3(i, j + 1, 3) +
                      pdhzl[k][4] * _u3(i, j + 1, 4) +
                      pdhzl[k][5] * _u3(i, j + 1, 5) +
                      pdhzl[k][6] * _u3(i, j + 1, 6) +
                      pdhzl[k][7] * _u3(i, j + 1, 7) +
                      pdhzl[k][8] * _u3(i, j + 1, 8)) +
                 py[3] * _f2_c(i, j + 2) *
                     (pdhzl[k][0] * _u3(i, j + 2, 0) +
                      pdhzl[k][1] * _u3(i, j + 2, 1) +
                      pdhzl[k][2] * _u3(i, j + 2, 2) +
                      pdhzl[k][3] * _u3(i, j + 2, 3) +
                      pdhzl[k][4] * _u3(i, j + 2, 4) +
                      pdhzl[k][5] * _u3(i, j + 2, 5) +
                      pdhzl[k][6] * _u3(i, j + 2, 6) +
                      pdhzl[k][7] * _u3(i, j + 2, 7) +
                      pdhzl[k][8] * _u3(i, j + 2, 8))))) *
      f_dcrj;
#undef _f_c
#undef _g3_c
#undef _f
#undef _f_1
#undef _g3
#undef _f_2
#undef _lami
#undef _mui
#undef _u2
#undef _f2_2
#undef _u3
#undef _g_c
#undef _f1_1
#undef _u1
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _s11
#undef _s22
#undef _s33
#undef _f1_2
#undef _f2_1
#undef _s12
#undef _g
#undef _s13
#undef _f1_c
#undef _s23
#undef _f2_c
}

__global__ void dtopo_str_111(
    float *s11, float *s12, float *s13, float *s22, float *s23, float *s33,
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *lami,
    const float *mui, const float a, const float nu, const int nx, const int ny,
    const int nz, const int bi, const int bj, const int ei, const int ej) {
  const float phz[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dhz[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float phdz[7] = {-0.0026041666666667, 0.0937500000000000,
                         -0.6796875000000000, -0.0000000000000000,
                         0.6796875000000000,  -0.0937500000000000,
                         0.0026041666666667};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dz[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float pdhz[7] = {-0.0026041666666667, 0.0937500000000000,
                         -0.6796875000000000, -0.0000000000000000,
                         0.6796875000000000,  -0.0937500000000000,
                         0.0026041666666667};
  const int i = threadIdx.x + blockIdx.x * blockDim.x + bi;
  if (i >= ngsl + nx)
    return;
  if (i >= ei)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ngsl + ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= nz - 12)
    return;
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _lami(i, j, k)                                                         \
  lami[(k) + align +                                                           \
       (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +             \
       (2 * align + nz) * ((j) + ngsl + 2)]
#define _mui(i, j, k)                                                          \
  mui[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
  float Jii = _f_c(i, j) * _g3_c(k + 6);
  Jii = 1.0 * 1.0 / Jii;
  float J12i = _f(i, j) * _g3_c(k + 6);
  J12i = 1.0 * 1.0 / J12i;
  float J13i = _f_1(i, j) * _g3(k + 6);
  J13i = 1.0 * 1.0 / J13i;
  float J23i = _f_2(i, j) * _g3(k + 6);
  J23i = 1.0 * 1.0 / J23i;
  float lam = nu * 1.0 /
              (phz[0] * (phy[2] * (px[1] * _lami(i, j, k + 4) +
                                   px[0] * _lami(i - 1, j, k + 4) +
                                   px[2] * _lami(i + 1, j, k + 4) +
                                   px[3] * _lami(i + 2, j, k + 4)) +
                         phy[0] * (px[1] * _lami(i, j - 2, k + 4) +
                                   px[0] * _lami(i - 1, j - 2, k + 4) +
                                   px[2] * _lami(i + 1, j - 2, k + 4) +
                                   px[3] * _lami(i + 2, j - 2, k + 4)) +
                         phy[1] * (px[1] * _lami(i, j - 1, k + 4) +
                                   px[0] * _lami(i - 1, j - 1, k + 4) +
                                   px[2] * _lami(i + 1, j - 1, k + 4) +
                                   px[3] * _lami(i + 2, j - 1, k + 4)) +
                         phy[3] * (px[1] * _lami(i, j + 1, k + 4) +
                                   px[0] * _lami(i - 1, j + 1, k + 4) +
                                   px[2] * _lami(i + 1, j + 1, k + 4) +
                                   px[3] * _lami(i + 2, j + 1, k + 4))) +
               phz[1] * (phy[2] * (px[1] * _lami(i, j, k + 5) +
                                   px[0] * _lami(i - 1, j, k + 5) +
                                   px[2] * _lami(i + 1, j, k + 5) +
                                   px[3] * _lami(i + 2, j, k + 5)) +
                         phy[0] * (px[1] * _lami(i, j - 2, k + 5) +
                                   px[0] * _lami(i - 1, j - 2, k + 5) +
                                   px[2] * _lami(i + 1, j - 2, k + 5) +
                                   px[3] * _lami(i + 2, j - 2, k + 5)) +
                         phy[1] * (px[1] * _lami(i, j - 1, k + 5) +
                                   px[0] * _lami(i - 1, j - 1, k + 5) +
                                   px[2] * _lami(i + 1, j - 1, k + 5) +
                                   px[3] * _lami(i + 2, j - 1, k + 5)) +
                         phy[3] * (px[1] * _lami(i, j + 1, k + 5) +
                                   px[0] * _lami(i - 1, j + 1, k + 5) +
                                   px[2] * _lami(i + 1, j + 1, k + 5) +
                                   px[3] * _lami(i + 2, j + 1, k + 5))) +
               phz[2] * (phy[2] * (px[1] * _lami(i, j, k + 6) +
                                   px[0] * _lami(i - 1, j, k + 6) +
                                   px[2] * _lami(i + 1, j, k + 6) +
                                   px[3] * _lami(i + 2, j, k + 6)) +
                         phy[0] * (px[1] * _lami(i, j - 2, k + 6) +
                                   px[0] * _lami(i - 1, j - 2, k + 6) +
                                   px[2] * _lami(i + 1, j - 2, k + 6) +
                                   px[3] * _lami(i + 2, j - 2, k + 6)) +
                         phy[1] * (px[1] * _lami(i, j - 1, k + 6) +
                                   px[0] * _lami(i - 1, j - 1, k + 6) +
                                   px[2] * _lami(i + 1, j - 1, k + 6) +
                                   px[3] * _lami(i + 2, j - 1, k + 6)) +
                         phy[3] * (px[1] * _lami(i, j + 1, k + 6) +
                                   px[0] * _lami(i - 1, j + 1, k + 6) +
                                   px[2] * _lami(i + 1, j + 1, k + 6) +
                                   px[3] * _lami(i + 2, j + 1, k + 6))) +
               phz[3] * (phy[2] * (px[1] * _lami(i, j, k + 7) +
                                   px[0] * _lami(i - 1, j, k + 7) +
                                   px[2] * _lami(i + 1, j, k + 7) +
                                   px[3] * _lami(i + 2, j, k + 7)) +
                         phy[0] * (px[1] * _lami(i, j - 2, k + 7) +
                                   px[0] * _lami(i - 1, j - 2, k + 7) +
                                   px[2] * _lami(i + 1, j - 2, k + 7) +
                                   px[3] * _lami(i + 2, j - 2, k + 7)) +
                         phy[1] * (px[1] * _lami(i, j - 1, k + 7) +
                                   px[0] * _lami(i - 1, j - 1, k + 7) +
                                   px[2] * _lami(i + 1, j - 1, k + 7) +
                                   px[3] * _lami(i + 2, j - 1, k + 7)) +
                         phy[3] * (px[1] * _lami(i, j + 1, k + 7) +
                                   px[0] * _lami(i - 1, j + 1, k + 7) +
                                   px[2] * _lami(i + 1, j + 1, k + 7) +
                                   px[3] * _lami(i + 2, j + 1, k + 7))));
  float twomu = 2 * nu * 1.0 /
                (phz[0] * (phy[2] * (px[1] * _mui(i, j, k + 4) +
                                     px[0] * _mui(i - 1, j, k + 4) +
                                     px[2] * _mui(i + 1, j, k + 4) +
                                     px[3] * _mui(i + 2, j, k + 4)) +
                           phy[0] * (px[1] * _mui(i, j - 2, k + 4) +
                                     px[0] * _mui(i - 1, j - 2, k + 4) +
                                     px[2] * _mui(i + 1, j - 2, k + 4) +
                                     px[3] * _mui(i + 2, j - 2, k + 4)) +
                           phy[1] * (px[1] * _mui(i, j - 1, k + 4) +
                                     px[0] * _mui(i - 1, j - 1, k + 4) +
                                     px[2] * _mui(i + 1, j - 1, k + 4) +
                                     px[3] * _mui(i + 2, j - 1, k + 4)) +
                           phy[3] * (px[1] * _mui(i, j + 1, k + 4) +
                                     px[0] * _mui(i - 1, j + 1, k + 4) +
                                     px[2] * _mui(i + 1, j + 1, k + 4) +
                                     px[3] * _mui(i + 2, j + 1, k + 4))) +
                 phz[1] * (phy[2] * (px[1] * _mui(i, j, k + 5) +
                                     px[0] * _mui(i - 1, j, k + 5) +
                                     px[2] * _mui(i + 1, j, k + 5) +
                                     px[3] * _mui(i + 2, j, k + 5)) +
                           phy[0] * (px[1] * _mui(i, j - 2, k + 5) +
                                     px[0] * _mui(i - 1, j - 2, k + 5) +
                                     px[2] * _mui(i + 1, j - 2, k + 5) +
                                     px[3] * _mui(i + 2, j - 2, k + 5)) +
                           phy[1] * (px[1] * _mui(i, j - 1, k + 5) +
                                     px[0] * _mui(i - 1, j - 1, k + 5) +
                                     px[2] * _mui(i + 1, j - 1, k + 5) +
                                     px[3] * _mui(i + 2, j - 1, k + 5)) +
                           phy[3] * (px[1] * _mui(i, j + 1, k + 5) +
                                     px[0] * _mui(i - 1, j + 1, k + 5) +
                                     px[2] * _mui(i + 1, j + 1, k + 5) +
                                     px[3] * _mui(i + 2, j + 1, k + 5))) +
                 phz[2] * (phy[2] * (px[1] * _mui(i, j, k + 6) +
                                     px[0] * _mui(i - 1, j, k + 6) +
                                     px[2] * _mui(i + 1, j, k + 6) +
                                     px[3] * _mui(i + 2, j, k + 6)) +
                           phy[0] * (px[1] * _mui(i, j - 2, k + 6) +
                                     px[0] * _mui(i - 1, j - 2, k + 6) +
                                     px[2] * _mui(i + 1, j - 2, k + 6) +
                                     px[3] * _mui(i + 2, j - 2, k + 6)) +
                           phy[1] * (px[1] * _mui(i, j - 1, k + 6) +
                                     px[0] * _mui(i - 1, j - 1, k + 6) +
                                     px[2] * _mui(i + 1, j - 1, k + 6) +
                                     px[3] * _mui(i + 2, j - 1, k + 6)) +
                           phy[3] * (px[1] * _mui(i, j + 1, k + 6) +
                                     px[0] * _mui(i - 1, j + 1, k + 6) +
                                     px[2] * _mui(i + 1, j + 1, k + 6) +
                                     px[3] * _mui(i + 2, j + 1, k + 6))) +
                 phz[3] * (phy[2] * (px[1] * _mui(i, j, k + 7) +
                                     px[0] * _mui(i - 1, j, k + 7) +
                                     px[2] * _mui(i + 1, j, k + 7) +
                                     px[3] * _mui(i + 2, j, k + 7)) +
                           phy[0] * (px[1] * _mui(i, j - 2, k + 7) +
                                     px[0] * _mui(i - 1, j - 2, k + 7) +
                                     px[2] * _mui(i + 1, j - 2, k + 7) +
                                     px[3] * _mui(i + 2, j - 2, k + 7)) +
                           phy[1] * (px[1] * _mui(i, j - 1, k + 7) +
                                     px[0] * _mui(i - 1, j - 1, k + 7) +
                                     px[2] * _mui(i + 1, j - 1, k + 7) +
                                     px[3] * _mui(i + 2, j - 1, k + 7)) +
                           phy[3] * (px[1] * _mui(i, j + 1, k + 7) +
                                     px[0] * _mui(i - 1, j + 1, k + 7) +
                                     px[2] * _mui(i + 1, j + 1, k + 7) +
                                     px[3] * _mui(i + 2, j + 1, k + 7))));
  float mu12 = nu * 1.0 /
               (phz[0] * _mui(i, j, k + 4) + phz[1] * _mui(i, j, k + 5) +
                phz[2] * _mui(i, j, k + 6) + phz[3] * _mui(i, j, k + 7));
  float mu13 =
      nu * 1.0 /
      (phy[2] * _mui(i, j, k + 6) + phy[0] * _mui(i, j - 2, k + 6) +
       phy[1] * _mui(i, j - 1, k + 6) + phy[3] * _mui(i, j + 1, k + 6));
  float mu23 = nu * 1.0 /
               (px[1] * _mui(i, j, k + 6) + px[0] * _mui(i - 1, j, k + 6) +
                px[2] * _mui(i + 1, j, k + 6) + px[3] * _mui(i + 2, j, k + 6));
  float div =
      dhy[2] * _u2(i, j, k + 6) + dhy[0] * _u2(i, j - 2, k + 6) +
      dhy[1] * _u2(i, j - 1, k + 6) + dhy[3] * _u2(i, j + 1, k + 6) +
      dx[1] * _u1(i, j, k + 6) + dx[0] * _u1(i - 1, j, k + 6) +
      dx[2] * _u1(i + 1, j, k + 6) + dx[3] * _u1(i + 2, j, k + 6) +
      Jii * (dhz[0] * _u3(i, j, k + 4) + dhz[1] * _u3(i, j, k + 5) +
             dhz[2] * _u3(i, j, k + 6) + dhz[3] * _u3(i, j, k + 7)) -
      Jii * _g_c(k + 6) *
          (phy[2] * _f2_2(i, j) *
               (phdz[0] * _u2(i, j, k + 3) + phdz[1] * _u2(i, j, k + 4) +
                phdz[2] * _u2(i, j, k + 5) + phdz[3] * _u2(i, j, k + 6) +
                phdz[4] * _u2(i, j, k + 7) + phdz[5] * _u2(i, j, k + 8) +
                phdz[6] * _u2(i, j, k + 9)) +
           phy[0] * _f2_2(i, j - 2) *
               (phdz[0] * _u2(i, j - 2, k + 3) +
                phdz[1] * _u2(i, j - 2, k + 4) +
                phdz[2] * _u2(i, j - 2, k + 5) +
                phdz[3] * _u2(i, j - 2, k + 6) +
                phdz[4] * _u2(i, j - 2, k + 7) +
                phdz[5] * _u2(i, j - 2, k + 8) +
                phdz[6] * _u2(i, j - 2, k + 9)) +
           phy[1] * _f2_2(i, j - 1) *
               (phdz[0] * _u2(i, j - 1, k + 3) +
                phdz[1] * _u2(i, j - 1, k + 4) +
                phdz[2] * _u2(i, j - 1, k + 5) +
                phdz[3] * _u2(i, j - 1, k + 6) +
                phdz[4] * _u2(i, j - 1, k + 7) +
                phdz[5] * _u2(i, j - 1, k + 8) +
                phdz[6] * _u2(i, j - 1, k + 9)) +
           phy[3] * _f2_2(i, j + 1) *
               (phdz[0] * _u2(i, j + 1, k + 3) +
                phdz[1] * _u2(i, j + 1, k + 4) +
                phdz[2] * _u2(i, j + 1, k + 5) +
                phdz[3] * _u2(i, j + 1, k + 6) +
                phdz[4] * _u2(i, j + 1, k + 7) +
                phdz[5] * _u2(i, j + 1, k + 8) +
                phdz[6] * _u2(i, j + 1, k + 9))) -
      Jii * _g_c(k + 6) *
          (px[1] * _f1_1(i, j) *
               (phdz[0] * _u1(i, j, k + 3) + phdz[1] * _u1(i, j, k + 4) +
                phdz[2] * _u1(i, j, k + 5) + phdz[3] * _u1(i, j, k + 6) +
                phdz[4] * _u1(i, j, k + 7) + phdz[5] * _u1(i, j, k + 8) +
                phdz[6] * _u1(i, j, k + 9)) +
           px[0] * _f1_1(i - 1, j) *
               (phdz[0] * _u1(i - 1, j, k + 3) +
                phdz[1] * _u1(i - 1, j, k + 4) +
                phdz[2] * _u1(i - 1, j, k + 5) +
                phdz[3] * _u1(i - 1, j, k + 6) +
                phdz[4] * _u1(i - 1, j, k + 7) +
                phdz[5] * _u1(i - 1, j, k + 8) +
                phdz[6] * _u1(i - 1, j, k + 9)) +
           px[2] * _f1_1(i + 1, j) *
               (phdz[0] * _u1(i + 1, j, k + 3) +
                phdz[1] * _u1(i + 1, j, k + 4) +
                phdz[2] * _u1(i + 1, j, k + 5) +
                phdz[3] * _u1(i + 1, j, k + 6) +
                phdz[4] * _u1(i + 1, j, k + 7) +
                phdz[5] * _u1(i + 1, j, k + 8) +
                phdz[6] * _u1(i + 1, j, k + 9)) +
           px[3] * _f1_1(i + 2, j) *
               (phdz[0] * _u1(i + 2, j, k + 3) +
                phdz[1] * _u1(i + 2, j, k + 4) +
                phdz[2] * _u1(i + 2, j, k + 5) +
                phdz[3] * _u1(i + 2, j, k + 6) +
                phdz[4] * _u1(i + 2, j, k + 7) +
                phdz[5] * _u1(i + 2, j, k + 8) +
                phdz[6] * _u1(i + 2, j, k + 9)));
  float f_dcrj = _dcrjx(i) * _dcrjy(j) * _dcrjz(k + 6);
  _s11(i, j, k + 6) =
      (a * _s11(i, j, k + 6) + lam * div +
       twomu * (dx[1] * _u1(i, j, k + 6) + dx[0] * _u1(i - 1, j, k + 6) +
                dx[2] * _u1(i + 1, j, k + 6) + dx[3] * _u1(i + 2, j, k + 6)) -
       twomu * Jii * _g_c(k + 6) *
           (px[1] * _f1_1(i, j) *
                (phdz[0] * _u1(i, j, k + 3) + phdz[1] * _u1(i, j, k + 4) +
                 phdz[2] * _u1(i, j, k + 5) + phdz[3] * _u1(i, j, k + 6) +
                 phdz[4] * _u1(i, j, k + 7) + phdz[5] * _u1(i, j, k + 8) +
                 phdz[6] * _u1(i, j, k + 9)) +
            px[0] * _f1_1(i - 1, j) *
                (phdz[0] * _u1(i - 1, j, k + 3) +
                 phdz[1] * _u1(i - 1, j, k + 4) +
                 phdz[2] * _u1(i - 1, j, k + 5) +
                 phdz[3] * _u1(i - 1, j, k + 6) +
                 phdz[4] * _u1(i - 1, j, k + 7) +
                 phdz[5] * _u1(i - 1, j, k + 8) +
                 phdz[6] * _u1(i - 1, j, k + 9)) +
            px[2] * _f1_1(i + 1, j) *
                (phdz[0] * _u1(i + 1, j, k + 3) +
                 phdz[1] * _u1(i + 1, j, k + 4) +
                 phdz[2] * _u1(i + 1, j, k + 5) +
                 phdz[3] * _u1(i + 1, j, k + 6) +
                 phdz[4] * _u1(i + 1, j, k + 7) +
                 phdz[5] * _u1(i + 1, j, k + 8) +
                 phdz[6] * _u1(i + 1, j, k + 9)) +
            px[3] * _f1_1(i + 2, j) *
                (phdz[0] * _u1(i + 2, j, k + 3) +
                 phdz[1] * _u1(i + 2, j, k + 4) +
                 phdz[2] * _u1(i + 2, j, k + 5) +
                 phdz[3] * _u1(i + 2, j, k + 6) +
                 phdz[4] * _u1(i + 2, j, k + 7) +
                 phdz[5] * _u1(i + 2, j, k + 8) +
                 phdz[6] * _u1(i + 2, j, k + 9)))) *
      f_dcrj;
  _s22(i, j, k + 6) =
      (a * _s22(i, j, k + 6) + lam * div +
       twomu * (dhy[2] * _u2(i, j, k + 6) + dhy[0] * _u2(i, j - 2, k + 6) +
                dhy[1] * _u2(i, j - 1, k + 6) + dhy[3] * _u2(i, j + 1, k + 6)) -
       twomu * Jii * _g_c(k + 6) *
           (phy[2] * _f2_2(i, j) *
                (phdz[0] * _u2(i, j, k + 3) + phdz[1] * _u2(i, j, k + 4) +
                 phdz[2] * _u2(i, j, k + 5) + phdz[3] * _u2(i, j, k + 6) +
                 phdz[4] * _u2(i, j, k + 7) + phdz[5] * _u2(i, j, k + 8) +
                 phdz[6] * _u2(i, j, k + 9)) +
            phy[0] * _f2_2(i, j - 2) *
                (phdz[0] * _u2(i, j - 2, k + 3) +
                 phdz[1] * _u2(i, j - 2, k + 4) +
                 phdz[2] * _u2(i, j - 2, k + 5) +
                 phdz[3] * _u2(i, j - 2, k + 6) +
                 phdz[4] * _u2(i, j - 2, k + 7) +
                 phdz[5] * _u2(i, j - 2, k + 8) +
                 phdz[6] * _u2(i, j - 2, k + 9)) +
            phy[1] * _f2_2(i, j - 1) *
                (phdz[0] * _u2(i, j - 1, k + 3) +
                 phdz[1] * _u2(i, j - 1, k + 4) +
                 phdz[2] * _u2(i, j - 1, k + 5) +
                 phdz[3] * _u2(i, j - 1, k + 6) +
                 phdz[4] * _u2(i, j - 1, k + 7) +
                 phdz[5] * _u2(i, j - 1, k + 8) +
                 phdz[6] * _u2(i, j - 1, k + 9)) +
            phy[3] * _f2_2(i, j + 1) *
                (phdz[0] * _u2(i, j + 1, k + 3) +
                 phdz[1] * _u2(i, j + 1, k + 4) +
                 phdz[2] * _u2(i, j + 1, k + 5) +
                 phdz[3] * _u2(i, j + 1, k + 6) +
                 phdz[4] * _u2(i, j + 1, k + 7) +
                 phdz[5] * _u2(i, j + 1, k + 8) +
                 phdz[6] * _u2(i, j + 1, k + 9)))) *
      f_dcrj;
  _s33(i, j, k + 6) =
      (a * _s33(i, j, k + 6) + lam * div +
       twomu * Jii *
           (dhz[0] * _u3(i, j, k + 4) + dhz[1] * _u3(i, j, k + 5) +
            dhz[2] * _u3(i, j, k + 6) + dhz[3] * _u3(i, j, k + 7))) *
      f_dcrj;
  _s12(i, j, k + 6) =
      (a * _s12(i, j, k + 6) +
       mu12 *
           (dhx[2] * _u2(i, j, k + 6) + dhx[0] * _u2(i - 2, j, k + 6) +
            dhx[1] * _u2(i - 1, j, k + 6) + dhx[3] * _u2(i + 1, j, k + 6) +
            dy[1] * _u1(i, j, k + 6) + dy[0] * _u1(i, j - 1, k + 6) +
            dy[2] * _u1(i, j + 1, k + 6) + dy[3] * _u1(i, j + 2, k + 6) -
            J12i * _g_c(k + 6) *
                (phx[2] * _f1_2(i, j) *
                     (phdz[0] * _u2(i, j, k + 3) + phdz[1] * _u2(i, j, k + 4) +
                      phdz[2] * _u2(i, j, k + 5) + phdz[3] * _u2(i, j, k + 6) +
                      phdz[4] * _u2(i, j, k + 7) + phdz[5] * _u2(i, j, k + 8) +
                      phdz[6] * _u2(i, j, k + 9)) +
                 phx[0] * _f1_2(i - 2, j) *
                     (phdz[0] * _u2(i - 2, j, k + 3) +
                      phdz[1] * _u2(i - 2, j, k + 4) +
                      phdz[2] * _u2(i - 2, j, k + 5) +
                      phdz[3] * _u2(i - 2, j, k + 6) +
                      phdz[4] * _u2(i - 2, j, k + 7) +
                      phdz[5] * _u2(i - 2, j, k + 8) +
                      phdz[6] * _u2(i - 2, j, k + 9)) +
                 phx[1] * _f1_2(i - 1, j) *
                     (phdz[0] * _u2(i - 1, j, k + 3) +
                      phdz[1] * _u2(i - 1, j, k + 4) +
                      phdz[2] * _u2(i - 1, j, k + 5) +
                      phdz[3] * _u2(i - 1, j, k + 6) +
                      phdz[4] * _u2(i - 1, j, k + 7) +
                      phdz[5] * _u2(i - 1, j, k + 8) +
                      phdz[6] * _u2(i - 1, j, k + 9)) +
                 phx[3] * _f1_2(i + 1, j) *
                     (phdz[0] * _u2(i + 1, j, k + 3) +
                      phdz[1] * _u2(i + 1, j, k + 4) +
                      phdz[2] * _u2(i + 1, j, k + 5) +
                      phdz[3] * _u2(i + 1, j, k + 6) +
                      phdz[4] * _u2(i + 1, j, k + 7) +
                      phdz[5] * _u2(i + 1, j, k + 8) +
                      phdz[6] * _u2(i + 1, j, k + 9))) -
            J12i * _g_c(k + 6) *
                (py[1] * _f2_1(i, j) *
                     (phdz[0] * _u1(i, j, k + 3) + phdz[1] * _u1(i, j, k + 4) +
                      phdz[2] * _u1(i, j, k + 5) + phdz[3] * _u1(i, j, k + 6) +
                      phdz[4] * _u1(i, j, k + 7) + phdz[5] * _u1(i, j, k + 8) +
                      phdz[6] * _u1(i, j, k + 9)) +
                 py[0] * _f2_1(i, j - 1) *
                     (phdz[0] * _u1(i, j - 1, k + 3) +
                      phdz[1] * _u1(i, j - 1, k + 4) +
                      phdz[2] * _u1(i, j - 1, k + 5) +
                      phdz[3] * _u1(i, j - 1, k + 6) +
                      phdz[4] * _u1(i, j - 1, k + 7) +
                      phdz[5] * _u1(i, j - 1, k + 8) +
                      phdz[6] * _u1(i, j - 1, k + 9)) +
                 py[2] * _f2_1(i, j + 1) *
                     (phdz[0] * _u1(i, j + 1, k + 3) +
                      phdz[1] * _u1(i, j + 1, k + 4) +
                      phdz[2] * _u1(i, j + 1, k + 5) +
                      phdz[3] * _u1(i, j + 1, k + 6) +
                      phdz[4] * _u1(i, j + 1, k + 7) +
                      phdz[5] * _u1(i, j + 1, k + 8) +
                      phdz[6] * _u1(i, j + 1, k + 9)) +
                 py[3] * _f2_1(i, j + 2) *
                     (phdz[0] * _u1(i, j + 2, k + 3) +
                      phdz[1] * _u1(i, j + 2, k + 4) +
                      phdz[2] * _u1(i, j + 2, k + 5) +
                      phdz[3] * _u1(i, j + 2, k + 6) +
                      phdz[4] * _u1(i, j + 2, k + 7) +
                      phdz[5] * _u1(i, j + 2, k + 8) +
                      phdz[6] * _u1(i, j + 2, k + 9))))) *
      f_dcrj;
  _s13(i, j, k + 6) =
      (a * _s13(i, j, k + 6) +
       mu13 *
           (dhx[2] * _u3(i, j, k + 6) + dhx[0] * _u3(i - 2, j, k + 6) +
            dhx[1] * _u3(i - 1, j, k + 6) + dhx[3] * _u3(i + 1, j, k + 6) +
            J13i * (dz[0] * _u1(i, j, k + 5) + dz[1] * _u1(i, j, k + 6) +
                    dz[2] * _u1(i, j, k + 7) + dz[3] * _u1(i, j, k + 8)) -
            J13i * _g(k + 6) *
                (phx[2] * _f1_c(i, j) *
                     (pdhz[0] * _u3(i, j, k + 3) + pdhz[1] * _u3(i, j, k + 4) +
                      pdhz[2] * _u3(i, j, k + 5) + pdhz[3] * _u3(i, j, k + 6) +
                      pdhz[4] * _u3(i, j, k + 7) + pdhz[5] * _u3(i, j, k + 8) +
                      pdhz[6] * _u3(i, j, k + 9)) +
                 phx[0] * _f1_c(i - 2, j) *
                     (pdhz[0] * _u3(i - 2, j, k + 3) +
                      pdhz[1] * _u3(i - 2, j, k + 4) +
                      pdhz[2] * _u3(i - 2, j, k + 5) +
                      pdhz[3] * _u3(i - 2, j, k + 6) +
                      pdhz[4] * _u3(i - 2, j, k + 7) +
                      pdhz[5] * _u3(i - 2, j, k + 8) +
                      pdhz[6] * _u3(i - 2, j, k + 9)) +
                 phx[1] * _f1_c(i - 1, j) *
                     (pdhz[0] * _u3(i - 1, j, k + 3) +
                      pdhz[1] * _u3(i - 1, j, k + 4) +
                      pdhz[2] * _u3(i - 1, j, k + 5) +
                      pdhz[3] * _u3(i - 1, j, k + 6) +
                      pdhz[4] * _u3(i - 1, j, k + 7) +
                      pdhz[5] * _u3(i - 1, j, k + 8) +
                      pdhz[6] * _u3(i - 1, j, k + 9)) +
                 phx[3] * _f1_c(i + 1, j) *
                     (pdhz[0] * _u3(i + 1, j, k + 3) +
                      pdhz[1] * _u3(i + 1, j, k + 4) +
                      pdhz[2] * _u3(i + 1, j, k + 5) +
                      pdhz[3] * _u3(i + 1, j, k + 6) +
                      pdhz[4] * _u3(i + 1, j, k + 7) +
                      pdhz[5] * _u3(i + 1, j, k + 8) +
                      pdhz[6] * _u3(i + 1, j, k + 9))))) *
      f_dcrj;
  _s23(i, j, k + 6) =
      (a * _s23(i, j, k + 6) +
       mu23 *
           (dy[1] * _u3(i, j, k + 6) + dy[0] * _u3(i, j - 1, k + 6) +
            dy[2] * _u3(i, j + 1, k + 6) + dy[3] * _u3(i, j + 2, k + 6) +
            J23i * (dz[0] * _u2(i, j, k + 5) + dz[1] * _u2(i, j, k + 6) +
                    dz[2] * _u2(i, j, k + 7) + dz[3] * _u2(i, j, k + 8)) -
            J23i * _g(k + 6) *
                (py[1] * _f2_c(i, j) *
                     (pdhz[0] * _u3(i, j, k + 3) + pdhz[1] * _u3(i, j, k + 4) +
                      pdhz[2] * _u3(i, j, k + 5) + pdhz[3] * _u3(i, j, k + 6) +
                      pdhz[4] * _u3(i, j, k + 7) + pdhz[5] * _u3(i, j, k + 8) +
                      pdhz[6] * _u3(i, j, k + 9)) +
                 py[0] * _f2_c(i, j - 1) *
                     (pdhz[0] * _u3(i, j - 1, k + 3) +
                      pdhz[1] * _u3(i, j - 1, k + 4) +
                      pdhz[2] * _u3(i, j - 1, k + 5) +
                      pdhz[3] * _u3(i, j - 1, k + 6) +
                      pdhz[4] * _u3(i, j - 1, k + 7) +
                      pdhz[5] * _u3(i, j - 1, k + 8) +
                      pdhz[6] * _u3(i, j - 1, k + 9)) +
                 py[2] * _f2_c(i, j + 1) *
                     (pdhz[0] * _u3(i, j + 1, k + 3) +
                      pdhz[1] * _u3(i, j + 1, k + 4) +
                      pdhz[2] * _u3(i, j + 1, k + 5) +
                      pdhz[3] * _u3(i, j + 1, k + 6) +
                      pdhz[4] * _u3(i, j + 1, k + 7) +
                      pdhz[5] * _u3(i, j + 1, k + 8) +
                      pdhz[6] * _u3(i, j + 1, k + 9)) +
                 py[3] * _f2_c(i, j + 2) *
                     (pdhz[0] * _u3(i, j + 2, k + 3) +
                      pdhz[1] * _u3(i, j + 2, k + 4) +
                      pdhz[2] * _u3(i, j + 2, k + 5) +
                      pdhz[3] * _u3(i, j + 2, k + 6) +
                      pdhz[4] * _u3(i, j + 2, k + 7) +
                      pdhz[5] * _u3(i, j + 2, k + 8) +
                      pdhz[6] * _u3(i, j + 2, k + 9))))) *
      f_dcrj;
#undef _f_c
#undef _g3_c
#undef _f
#undef _f_1
#undef _g3
#undef _f_2
#undef _lami
#undef _mui
#undef _u2
#undef _f2_2
#undef _u3
#undef _g_c
#undef _f1_1
#undef _u1
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _s11
#undef _s22
#undef _s33
#undef _f1_2
#undef _f2_1
#undef _s12
#undef _g
#undef _s13
#undef _f1_c
#undef _s23
#undef _f2_c
}

__global__ void dtopo_str_112(
    float *s11, float *s12, float *s13, float *s22, float *s23, float *s33,
    float *u1, float *u2, float *u3, const float *dcrjx, const float *dcrjy,
    const float *dcrjz, const float *f, const float *f1_1, const float *f1_2,
    const float *f1_c, const float *f2_1, const float *f2_2, const float *f2_c,
    const float *f_1, const float *f_2, const float *f_c, const float *g,
    const float *g3, const float *g3_c, const float *g_c, const float *lami,
    const float *mui, const float a, const float nu, const int nx, const int ny,
    const int nz, const int bi, const int bj, const int ei, const int ej) {
  const float phzr[6][8] = {
      {0.0000000000000000, 0.8338228784688313, 0.1775123316429260,
       0.1435067013076542, -0.1548419114194114, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.1813404047323969, 1.1246711188154426,
       -0.2933634518280757, -0.0126480717197637, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.1331142706282399, 0.7930714675884345,
       0.3131998767078508, 0.0268429263319546, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0969078556633046, -0.1539344946680898,
       0.4486491202844389, 0.6768738207821733, -0.0684963020618270,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0625000000000000, 0.5625000000000000, 0.5625000000000000,
       -0.0625000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, -0.0625000000000000, 0.5625000000000000,
       0.5625000000000000, -0.0625000000000000}};
  const float phy[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float px[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dhzr[6][8] = {
      {0.0000000000000000, 1.4511412472637157, -1.8534237417911470,
       0.3534237417911469, 0.0488587527362844, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.8577143189081458, -0.5731429567244373,
       -0.4268570432755628, 0.1422856810918542, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.1674548505882877, 0.4976354482351368,
       -0.4976354482351368, -0.1674548505882877, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.1027061113405124, 0.2624541326469860,
       0.8288742701021167, -1.0342864927831414, 0.0456642013745513,
       0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0416666666666667, 1.1250000000000000, -1.1250000000000000,
       0.0416666666666667, 0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, -0.0416666666666667, 1.1250000000000000,
       -1.1250000000000000, 0.0416666666666667}};
  const float phdzr[6][9] = {
      {1.5373923010673116, -1.0330083346742178, -0.6211677623382129,
       -0.0454110758451345, 0.1680934225988761, -0.0058985508086226,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.8713921425924012, -0.1273679143938725, -0.9297550647681331,
       0.1912595577524762, -0.0050469052908678, -0.0004818158920039,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0563333965151294, 0.3996393739211770, 0.0536007135209481,
       -0.5022638816465500, -0.0083321572725344, 0.0010225549618299,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0132930497153990, -0.0706942590708847, 0.5596445380498726,
       0.1434031863528334, -0.7456356868769503, 0.1028431844156395,
       -0.0028540125859095, 0.0000000000000000, 0.0000000000000000},
      {0.0025849423769932, -0.0492307522105194, 0.0524552477068130,
       0.5317248489238559, 0.0530169938441240, -0.6816971139746001,
       0.0937500000000000, -0.0026041666666667, 0.0000000000000000},
      {0.0009619461344193, 0.0035553215968974, -0.0124936029037323,
       -0.0773639466787397, 0.6736586580761996, 0.0002232904416222,
       -0.6796875000000000, 0.0937500000000000, -0.0026041666666667}};
  const float dx[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dhy[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float phx[4] = {-0.0625000000000000, 0.5625000000000000,
                        0.5625000000000000, -0.0625000000000000};
  const float py[4] = {-0.0625000000000000, 0.5625000000000000,
                       0.5625000000000000, -0.0625000000000000};
  const float dy[4] = {0.0416666666666667, -1.1250000000000000,
                       1.1250000000000000, -0.0416666666666667};
  const float dhx[4] = {0.0416666666666667, -1.1250000000000000,
                        1.1250000000000000, -0.0416666666666667};
  const float dzr[6][7] = {
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {1.7779989465546748, -1.3337480247900155, -0.7775013168066564,
       0.3332503950419969, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {0.4410217341392059, 0.1730842484889890, -0.4487228323259926,
       -0.1653831503022022, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000},
      {-0.1798793213882701, 0.2757257254150788, 0.9597948548284453,
       -1.1171892610431817, 0.0615480021879277, 0.0000000000000000,
       0.0000000000000000},
      {-0.0153911381507088, -0.0568851455503591, 0.1998976464597171,
       0.8628231468598346, -1.0285385292191949, 0.0380940196007109,
       0.0000000000000000},
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       -0.0416666666666667, 1.1250000000000000, -1.1250000000000000,
       0.0416666666666667}};
  const float pdhzr[6][9] = {
      {0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 1.5886075042755419, -2.2801810182668114,
       0.8088980291471826, -0.1316830205960989, 0.0143585054401857,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, 0.4823226655921295, 0.0574614517751295,
       -0.5663203488781653, 0.0309656800624243, -0.0044294485515179,
       0.0000000000000000, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.0174954311279016, 0.4325508330649349,
       0.3111668377093504, -0.8538512002386446, 0.1314757107290064,
       -0.0038467501367455, 0.0000000000000000, 0.0000000000000000},
      {0.0000000000000000, -0.1277481742492071, 0.2574468839590017,
       0.4155794781917712, -0.0115571196122084, -0.6170517361659126,
       0.0857115441015996, -0.0023808762250444, 0.0000000000000000},
      {0.0000000000000000, 0.0064191319587820, -0.0164033832904366,
       -0.0752421418813823, 0.6740179057989464, -0.0002498459192428,
       -0.6796875000000000, 0.0937500000000000, -0.0026041666666667}};
  const int i = threadIdx.x + blockIdx.x * blockDim.x + bi;
  if (i >= ngsl + nx)
    return;
  if (i >= ei)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y + bj;
  if (j >= ngsl + ny)
    return;
  if (j >= ej)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= 6)
    return;
#define _f_c(i, j)                                                             \
  f_c[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3_c(k) g3_c[(k) + align]
#define _f(i, j)                                                               \
  f[(j) + align + ngsl + ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f_1(i, j)                                                             \
  f_1[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _g3(k) g3[(k) + align]
#define _f_2(i, j)                                                             \
  f_2[(j) + align + ngsl +                                                     \
      ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _lami(i, j, k)                                                         \
  lami[(k) + align +                                                           \
       (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +             \
       (2 * align + nz) * ((j) + ngsl + 2)]
#define _mui(i, j, k)                                                          \
  mui[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _u2(i, j, k)                                                           \
  u2[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_2(i, j)                                                            \
  f2_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u3(i, j, k)                                                           \
  u3[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _g_c(k) g_c[(k) + align]
#define _f1_1(i, j)                                                            \
  f1_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _u1(i, j, k)                                                           \
  u1[(k) + align + (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) + \
     (2 * align + nz) * ((j) + ngsl + 2)]
#define _dcrjx(i) dcrjx[(i) + ngsl + 2]
#define _dcrjz(k) dcrjz[(k) + align]
#define _dcrjy(j) dcrjy[(j) + ngsl + 2]
#define _s11(i, j, k)                                                          \
  s11[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _s22(i, j, k)                                                          \
  s22[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _s33(i, j, k)                                                          \
  s33[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_2(i, j)                                                            \
  f1_2[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _f2_1(i, j)                                                            \
  f2_1[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s12(i, j, k)                                                          \
  s12[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _g(k) g[(k) + align]
#define _s13(i, j, k)                                                          \
  s13[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f1_c(i, j)                                                            \
  f1_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
#define _s23(i, j, k)                                                          \
  s23[(k) + align +                                                            \
      (2 * align + nz) * ((i) + ngsl + 2) * (2 * ngsl + ny + 4) +              \
      (2 * align + nz) * ((j) + ngsl + 2)]
#define _f2_c(i, j)                                                            \
  f2_c[(j) + align + ngsl +                                                    \
       ((i) + ngsl + 2) * (2 * align + 2 * ngsl + ny + 4) + 2]
  float Jii = _f_c(i, j) * _g3_c(nz - 1 - k);
  Jii = 1.0 * 1.0 / Jii;
  float J12i = _f(i, j) * _g3_c(nz - 1 - k);
  J12i = 1.0 * 1.0 / J12i;
  float J13i = _f_1(i, j) * _g3(nz - 1 - k);
  J13i = 1.0 * 1.0 / J13i;
  float J23i = _f_2(i, j) * _g3(nz - 1 - k);
  J23i = 1.0 * 1.0 / J23i;
  float lam = nu * 1.0 /
              (phzr[k][7] * (phy[2] * (px[1] * _lami(i, j, nz - 8) +
                                       px[0] * _lami(i - 1, j, nz - 8) +
                                       px[2] * _lami(i + 1, j, nz - 8) +
                                       px[3] * _lami(i + 2, j, nz - 8)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 8) +
                                       px[0] * _lami(i - 1, j - 2, nz - 8) +
                                       px[2] * _lami(i + 1, j - 2, nz - 8) +
                                       px[3] * _lami(i + 2, j - 2, nz - 8)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 8) +
                                       px[0] * _lami(i - 1, j - 1, nz - 8) +
                                       px[2] * _lami(i + 1, j - 1, nz - 8) +
                                       px[3] * _lami(i + 2, j - 1, nz - 8)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 8) +
                                       px[0] * _lami(i - 1, j + 1, nz - 8) +
                                       px[2] * _lami(i + 1, j + 1, nz - 8) +
                                       px[3] * _lami(i + 2, j + 1, nz - 8))) +
               phzr[k][6] * (phy[2] * (px[1] * _lami(i, j, nz - 7) +
                                       px[0] * _lami(i - 1, j, nz - 7) +
                                       px[2] * _lami(i + 1, j, nz - 7) +
                                       px[3] * _lami(i + 2, j, nz - 7)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 7) +
                                       px[0] * _lami(i - 1, j - 2, nz - 7) +
                                       px[2] * _lami(i + 1, j - 2, nz - 7) +
                                       px[3] * _lami(i + 2, j - 2, nz - 7)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 7) +
                                       px[0] * _lami(i - 1, j - 1, nz - 7) +
                                       px[2] * _lami(i + 1, j - 1, nz - 7) +
                                       px[3] * _lami(i + 2, j - 1, nz - 7)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 7) +
                                       px[0] * _lami(i - 1, j + 1, nz - 7) +
                                       px[2] * _lami(i + 1, j + 1, nz - 7) +
                                       px[3] * _lami(i + 2, j + 1, nz - 7))) +
               phzr[k][5] * (phy[2] * (px[1] * _lami(i, j, nz - 6) +
                                       px[0] * _lami(i - 1, j, nz - 6) +
                                       px[2] * _lami(i + 1, j, nz - 6) +
                                       px[3] * _lami(i + 2, j, nz - 6)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 6) +
                                       px[0] * _lami(i - 1, j - 2, nz - 6) +
                                       px[2] * _lami(i + 1, j - 2, nz - 6) +
                                       px[3] * _lami(i + 2, j - 2, nz - 6)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 6) +
                                       px[0] * _lami(i - 1, j - 1, nz - 6) +
                                       px[2] * _lami(i + 1, j - 1, nz - 6) +
                                       px[3] * _lami(i + 2, j - 1, nz - 6)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 6) +
                                       px[0] * _lami(i - 1, j + 1, nz - 6) +
                                       px[2] * _lami(i + 1, j + 1, nz - 6) +
                                       px[3] * _lami(i + 2, j + 1, nz - 6))) +
               phzr[k][4] * (phy[2] * (px[1] * _lami(i, j, nz - 5) +
                                       px[0] * _lami(i - 1, j, nz - 5) +
                                       px[2] * _lami(i + 1, j, nz - 5) +
                                       px[3] * _lami(i + 2, j, nz - 5)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 5) +
                                       px[0] * _lami(i - 1, j - 2, nz - 5) +
                                       px[2] * _lami(i + 1, j - 2, nz - 5) +
                                       px[3] * _lami(i + 2, j - 2, nz - 5)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 5) +
                                       px[0] * _lami(i - 1, j - 1, nz - 5) +
                                       px[2] * _lami(i + 1, j - 1, nz - 5) +
                                       px[3] * _lami(i + 2, j - 1, nz - 5)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 5) +
                                       px[0] * _lami(i - 1, j + 1, nz - 5) +
                                       px[2] * _lami(i + 1, j + 1, nz - 5) +
                                       px[3] * _lami(i + 2, j + 1, nz - 5))) +
               phzr[k][3] * (phy[2] * (px[1] * _lami(i, j, nz - 4) +
                                       px[0] * _lami(i - 1, j, nz - 4) +
                                       px[2] * _lami(i + 1, j, nz - 4) +
                                       px[3] * _lami(i + 2, j, nz - 4)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 4) +
                                       px[0] * _lami(i - 1, j - 2, nz - 4) +
                                       px[2] * _lami(i + 1, j - 2, nz - 4) +
                                       px[3] * _lami(i + 2, j - 2, nz - 4)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 4) +
                                       px[0] * _lami(i - 1, j - 1, nz - 4) +
                                       px[2] * _lami(i + 1, j - 1, nz - 4) +
                                       px[3] * _lami(i + 2, j - 1, nz - 4)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 4) +
                                       px[0] * _lami(i - 1, j + 1, nz - 4) +
                                       px[2] * _lami(i + 1, j + 1, nz - 4) +
                                       px[3] * _lami(i + 2, j + 1, nz - 4))) +
               phzr[k][2] * (phy[2] * (px[1] * _lami(i, j, nz - 3) +
                                       px[0] * _lami(i - 1, j, nz - 3) +
                                       px[2] * _lami(i + 1, j, nz - 3) +
                                       px[3] * _lami(i + 2, j, nz - 3)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 3) +
                                       px[0] * _lami(i - 1, j - 2, nz - 3) +
                                       px[2] * _lami(i + 1, j - 2, nz - 3) +
                                       px[3] * _lami(i + 2, j - 2, nz - 3)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 3) +
                                       px[0] * _lami(i - 1, j - 1, nz - 3) +
                                       px[2] * _lami(i + 1, j - 1, nz - 3) +
                                       px[3] * _lami(i + 2, j - 1, nz - 3)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 3) +
                                       px[0] * _lami(i - 1, j + 1, nz - 3) +
                                       px[2] * _lami(i + 1, j + 1, nz - 3) +
                                       px[3] * _lami(i + 2, j + 1, nz - 3))) +
               phzr[k][1] * (phy[2] * (px[1] * _lami(i, j, nz - 2) +
                                       px[0] * _lami(i - 1, j, nz - 2) +
                                       px[2] * _lami(i + 1, j, nz - 2) +
                                       px[3] * _lami(i + 2, j, nz - 2)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 2) +
                                       px[0] * _lami(i - 1, j - 2, nz - 2) +
                                       px[2] * _lami(i + 1, j - 2, nz - 2) +
                                       px[3] * _lami(i + 2, j - 2, nz - 2)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 2) +
                                       px[0] * _lami(i - 1, j - 1, nz - 2) +
                                       px[2] * _lami(i + 1, j - 1, nz - 2) +
                                       px[3] * _lami(i + 2, j - 1, nz - 2)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 2) +
                                       px[0] * _lami(i - 1, j + 1, nz - 2) +
                                       px[2] * _lami(i + 1, j + 1, nz - 2) +
                                       px[3] * _lami(i + 2, j + 1, nz - 2))) +
               phzr[k][0] * (phy[2] * (px[1] * _lami(i, j, nz - 1) +
                                       px[0] * _lami(i - 1, j, nz - 1) +
                                       px[2] * _lami(i + 1, j, nz - 1) +
                                       px[3] * _lami(i + 2, j, nz - 1)) +
                             phy[0] * (px[1] * _lami(i, j - 2, nz - 1) +
                                       px[0] * _lami(i - 1, j - 2, nz - 1) +
                                       px[2] * _lami(i + 1, j - 2, nz - 1) +
                                       px[3] * _lami(i + 2, j - 2, nz - 1)) +
                             phy[1] * (px[1] * _lami(i, j - 1, nz - 1) +
                                       px[0] * _lami(i - 1, j - 1, nz - 1) +
                                       px[2] * _lami(i + 1, j - 1, nz - 1) +
                                       px[3] * _lami(i + 2, j - 1, nz - 1)) +
                             phy[3] * (px[1] * _lami(i, j + 1, nz - 1) +
                                       px[0] * _lami(i - 1, j + 1, nz - 1) +
                                       px[2] * _lami(i + 1, j + 1, nz - 1) +
                                       px[3] * _lami(i + 2, j + 1, nz - 1))));
  float twomu = 2 * nu * 1.0 /
                (phzr[k][7] * (phy[2] * (px[1] * _mui(i, j, nz - 8) +
                                         px[0] * _mui(i - 1, j, nz - 8) +
                                         px[2] * _mui(i + 1, j, nz - 8) +
                                         px[3] * _mui(i + 2, j, nz - 8)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 8) +
                                         px[0] * _mui(i - 1, j - 2, nz - 8) +
                                         px[2] * _mui(i + 1, j - 2, nz - 8) +
                                         px[3] * _mui(i + 2, j - 2, nz - 8)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 8) +
                                         px[0] * _mui(i - 1, j - 1, nz - 8) +
                                         px[2] * _mui(i + 1, j - 1, nz - 8) +
                                         px[3] * _mui(i + 2, j - 1, nz - 8)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 8) +
                                         px[0] * _mui(i - 1, j + 1, nz - 8) +
                                         px[2] * _mui(i + 1, j + 1, nz - 8) +
                                         px[3] * _mui(i + 2, j + 1, nz - 8))) +
                 phzr[k][6] * (phy[2] * (px[1] * _mui(i, j, nz - 7) +
                                         px[0] * _mui(i - 1, j, nz - 7) +
                                         px[2] * _mui(i + 1, j, nz - 7) +
                                         px[3] * _mui(i + 2, j, nz - 7)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 7) +
                                         px[0] * _mui(i - 1, j - 2, nz - 7) +
                                         px[2] * _mui(i + 1, j - 2, nz - 7) +
                                         px[3] * _mui(i + 2, j - 2, nz - 7)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 7) +
                                         px[0] * _mui(i - 1, j - 1, nz - 7) +
                                         px[2] * _mui(i + 1, j - 1, nz - 7) +
                                         px[3] * _mui(i + 2, j - 1, nz - 7)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 7) +
                                         px[0] * _mui(i - 1, j + 1, nz - 7) +
                                         px[2] * _mui(i + 1, j + 1, nz - 7) +
                                         px[3] * _mui(i + 2, j + 1, nz - 7))) +
                 phzr[k][5] * (phy[2] * (px[1] * _mui(i, j, nz - 6) +
                                         px[0] * _mui(i - 1, j, nz - 6) +
                                         px[2] * _mui(i + 1, j, nz - 6) +
                                         px[3] * _mui(i + 2, j, nz - 6)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 6) +
                                         px[0] * _mui(i - 1, j - 2, nz - 6) +
                                         px[2] * _mui(i + 1, j - 2, nz - 6) +
                                         px[3] * _mui(i + 2, j - 2, nz - 6)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 6) +
                                         px[0] * _mui(i - 1, j - 1, nz - 6) +
                                         px[2] * _mui(i + 1, j - 1, nz - 6) +
                                         px[3] * _mui(i + 2, j - 1, nz - 6)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 6) +
                                         px[0] * _mui(i - 1, j + 1, nz - 6) +
                                         px[2] * _mui(i + 1, j + 1, nz - 6) +
                                         px[3] * _mui(i + 2, j + 1, nz - 6))) +
                 phzr[k][4] * (phy[2] * (px[1] * _mui(i, j, nz - 5) +
                                         px[0] * _mui(i - 1, j, nz - 5) +
                                         px[2] * _mui(i + 1, j, nz - 5) +
                                         px[3] * _mui(i + 2, j, nz - 5)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 5) +
                                         px[0] * _mui(i - 1, j - 2, nz - 5) +
                                         px[2] * _mui(i + 1, j - 2, nz - 5) +
                                         px[3] * _mui(i + 2, j - 2, nz - 5)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 5) +
                                         px[0] * _mui(i - 1, j - 1, nz - 5) +
                                         px[2] * _mui(i + 1, j - 1, nz - 5) +
                                         px[3] * _mui(i + 2, j - 1, nz - 5)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 5) +
                                         px[0] * _mui(i - 1, j + 1, nz - 5) +
                                         px[2] * _mui(i + 1, j + 1, nz - 5) +
                                         px[3] * _mui(i + 2, j + 1, nz - 5))) +
                 phzr[k][3] * (phy[2] * (px[1] * _mui(i, j, nz - 4) +
                                         px[0] * _mui(i - 1, j, nz - 4) +
                                         px[2] * _mui(i + 1, j, nz - 4) +
                                         px[3] * _mui(i + 2, j, nz - 4)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 4) +
                                         px[0] * _mui(i - 1, j - 2, nz - 4) +
                                         px[2] * _mui(i + 1, j - 2, nz - 4) +
                                         px[3] * _mui(i + 2, j - 2, nz - 4)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 4) +
                                         px[0] * _mui(i - 1, j - 1, nz - 4) +
                                         px[2] * _mui(i + 1, j - 1, nz - 4) +
                                         px[3] * _mui(i + 2, j - 1, nz - 4)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 4) +
                                         px[0] * _mui(i - 1, j + 1, nz - 4) +
                                         px[2] * _mui(i + 1, j + 1, nz - 4) +
                                         px[3] * _mui(i + 2, j + 1, nz - 4))) +
                 phzr[k][2] * (phy[2] * (px[1] * _mui(i, j, nz - 3) +
                                         px[0] * _mui(i - 1, j, nz - 3) +
                                         px[2] * _mui(i + 1, j, nz - 3) +
                                         px[3] * _mui(i + 2, j, nz - 3)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 3) +
                                         px[0] * _mui(i - 1, j - 2, nz - 3) +
                                         px[2] * _mui(i + 1, j - 2, nz - 3) +
                                         px[3] * _mui(i + 2, j - 2, nz - 3)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 3) +
                                         px[0] * _mui(i - 1, j - 1, nz - 3) +
                                         px[2] * _mui(i + 1, j - 1, nz - 3) +
                                         px[3] * _mui(i + 2, j - 1, nz - 3)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 3) +
                                         px[0] * _mui(i - 1, j + 1, nz - 3) +
                                         px[2] * _mui(i + 1, j + 1, nz - 3) +
                                         px[3] * _mui(i + 2, j + 1, nz - 3))) +
                 phzr[k][1] * (phy[2] * (px[1] * _mui(i, j, nz - 2) +
                                         px[0] * _mui(i - 1, j, nz - 2) +
                                         px[2] * _mui(i + 1, j, nz - 2) +
                                         px[3] * _mui(i + 2, j, nz - 2)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 2) +
                                         px[0] * _mui(i - 1, j - 2, nz - 2) +
                                         px[2] * _mui(i + 1, j - 2, nz - 2) +
                                         px[3] * _mui(i + 2, j - 2, nz - 2)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 2) +
                                         px[0] * _mui(i - 1, j - 1, nz - 2) +
                                         px[2] * _mui(i + 1, j - 1, nz - 2) +
                                         px[3] * _mui(i + 2, j - 1, nz - 2)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 2) +
                                         px[0] * _mui(i - 1, j + 1, nz - 2) +
                                         px[2] * _mui(i + 1, j + 1, nz - 2) +
                                         px[3] * _mui(i + 2, j + 1, nz - 2))) +
                 phzr[k][0] * (phy[2] * (px[1] * _mui(i, j, nz - 1) +
                                         px[0] * _mui(i - 1, j, nz - 1) +
                                         px[2] * _mui(i + 1, j, nz - 1) +
                                         px[3] * _mui(i + 2, j, nz - 1)) +
                               phy[0] * (px[1] * _mui(i, j - 2, nz - 1) +
                                         px[0] * _mui(i - 1, j - 2, nz - 1) +
                                         px[2] * _mui(i + 1, j - 2, nz - 1) +
                                         px[3] * _mui(i + 2, j - 2, nz - 1)) +
                               phy[1] * (px[1] * _mui(i, j - 1, nz - 1) +
                                         px[0] * _mui(i - 1, j - 1, nz - 1) +
                                         px[2] * _mui(i + 1, j - 1, nz - 1) +
                                         px[3] * _mui(i + 2, j - 1, nz - 1)) +
                               phy[3] * (px[1] * _mui(i, j + 1, nz - 1) +
                                         px[0] * _mui(i - 1, j + 1, nz - 1) +
                                         px[2] * _mui(i + 1, j + 1, nz - 1) +
                                         px[3] * _mui(i + 2, j + 1, nz - 1))));
  float mu12 =
      nu * 1.0 /
      (phzr[k][7] * _mui(i, j, nz - 8) + phzr[k][6] * _mui(i, j, nz - 7) +
       phzr[k][5] * _mui(i, j, nz - 6) + phzr[k][4] * _mui(i, j, nz - 5) +
       phzr[k][3] * _mui(i, j, nz - 4) + phzr[k][2] * _mui(i, j, nz - 3) +
       phzr[k][1] * _mui(i, j, nz - 2) + phzr[k][0] * _mui(i, j, nz - 1));
  float mu13 =
      nu * 1.0 /
      (phy[2] * _mui(i, j, nz - 1 - k) + phy[0] * _mui(i, j - 2, nz - 1 - k) +
       phy[1] * _mui(i, j - 1, nz - 1 - k) +
       phy[3] * _mui(i, j + 1, nz - 1 - k));
  float mu23 =
      nu * 1.0 /
      (px[1] * _mui(i, j, nz - 1 - k) + px[0] * _mui(i - 1, j, nz - 1 - k) +
       px[2] * _mui(i + 1, j, nz - 1 - k) + px[3] * _mui(i + 2, j, nz - 1 - k));
  float div =
      dhy[2] * _u2(i, j, nz - 1 - k) + dhy[0] * _u2(i, j - 2, nz - 1 - k) +
      dhy[1] * _u2(i, j - 1, nz - 1 - k) + dhy[3] * _u2(i, j + 1, nz - 1 - k) +
      dx[1] * _u1(i, j, nz - 1 - k) + dx[0] * _u1(i - 1, j, nz - 1 - k) +
      dx[2] * _u1(i + 1, j, nz - 1 - k) + dx[3] * _u1(i + 2, j, nz - 1 - k) +
      Jii * (dhzr[k][7] * _u3(i, j, nz - 8) + dhzr[k][6] * _u3(i, j, nz - 7) +
             dhzr[k][5] * _u3(i, j, nz - 6) + dhzr[k][4] * _u3(i, j, nz - 5) +
             dhzr[k][3] * _u3(i, j, nz - 4) + dhzr[k][2] * _u3(i, j, nz - 3) +
             dhzr[k][1] * _u3(i, j, nz - 2) + dhzr[k][0] * _u3(i, j, nz - 1)) -
      Jii * _g_c(nz - 1 - k) *
          (phy[2] * _f2_2(i, j) *
               (phdzr[k][8] * _u2(i, j, nz - 9) +
                phdzr[k][7] * _u2(i, j, nz - 8) +
                phdzr[k][6] * _u2(i, j, nz - 7) +
                phdzr[k][5] * _u2(i, j, nz - 6) +
                phdzr[k][4] * _u2(i, j, nz - 5) +
                phdzr[k][3] * _u2(i, j, nz - 4) +
                phdzr[k][2] * _u2(i, j, nz - 3) +
                phdzr[k][1] * _u2(i, j, nz - 2) +
                phdzr[k][0] * _u2(i, j, nz - 1)) +
           phy[0] * _f2_2(i, j - 2) *
               (phdzr[k][8] * _u2(i, j - 2, nz - 9) +
                phdzr[k][7] * _u2(i, j - 2, nz - 8) +
                phdzr[k][6] * _u2(i, j - 2, nz - 7) +
                phdzr[k][5] * _u2(i, j - 2, nz - 6) +
                phdzr[k][4] * _u2(i, j - 2, nz - 5) +
                phdzr[k][3] * _u2(i, j - 2, nz - 4) +
                phdzr[k][2] * _u2(i, j - 2, nz - 3) +
                phdzr[k][1] * _u2(i, j - 2, nz - 2) +
                phdzr[k][0] * _u2(i, j - 2, nz - 1)) +
           phy[1] * _f2_2(i, j - 1) *
               (phdzr[k][8] * _u2(i, j - 1, nz - 9) +
                phdzr[k][7] * _u2(i, j - 1, nz - 8) +
                phdzr[k][6] * _u2(i, j - 1, nz - 7) +
                phdzr[k][5] * _u2(i, j - 1, nz - 6) +
                phdzr[k][4] * _u2(i, j - 1, nz - 5) +
                phdzr[k][3] * _u2(i, j - 1, nz - 4) +
                phdzr[k][2] * _u2(i, j - 1, nz - 3) +
                phdzr[k][1] * _u2(i, j - 1, nz - 2) +
                phdzr[k][0] * _u2(i, j - 1, nz - 1)) +
           phy[3] * _f2_2(i, j + 1) *
               (phdzr[k][8] * _u2(i, j + 1, nz - 9) +
                phdzr[k][7] * _u2(i, j + 1, nz - 8) +
                phdzr[k][6] * _u2(i, j + 1, nz - 7) +
                phdzr[k][5] * _u2(i, j + 1, nz - 6) +
                phdzr[k][4] * _u2(i, j + 1, nz - 5) +
                phdzr[k][3] * _u2(i, j + 1, nz - 4) +
                phdzr[k][2] * _u2(i, j + 1, nz - 3) +
                phdzr[k][1] * _u2(i, j + 1, nz - 2) +
                phdzr[k][0] * _u2(i, j + 1, nz - 1))) -
      Jii * _g_c(nz - 1 - k) *
          (px[1] * _f1_1(i, j) *
               (phdzr[k][8] * _u1(i, j, nz - 9) +
                phdzr[k][7] * _u1(i, j, nz - 8) +
                phdzr[k][6] * _u1(i, j, nz - 7) +
                phdzr[k][5] * _u1(i, j, nz - 6) +
                phdzr[k][4] * _u1(i, j, nz - 5) +
                phdzr[k][3] * _u1(i, j, nz - 4) +
                phdzr[k][2] * _u1(i, j, nz - 3) +
                phdzr[k][1] * _u1(i, j, nz - 2) +
                phdzr[k][0] * _u1(i, j, nz - 1)) +
           px[0] * _f1_1(i - 1, j) *
               (phdzr[k][8] * _u1(i - 1, j, nz - 9) +
                phdzr[k][7] * _u1(i - 1, j, nz - 8) +
                phdzr[k][6] * _u1(i - 1, j, nz - 7) +
                phdzr[k][5] * _u1(i - 1, j, nz - 6) +
                phdzr[k][4] * _u1(i - 1, j, nz - 5) +
                phdzr[k][3] * _u1(i - 1, j, nz - 4) +
                phdzr[k][2] * _u1(i - 1, j, nz - 3) +
                phdzr[k][1] * _u1(i - 1, j, nz - 2) +
                phdzr[k][0] * _u1(i - 1, j, nz - 1)) +
           px[2] * _f1_1(i + 1, j) *
               (phdzr[k][8] * _u1(i + 1, j, nz - 9) +
                phdzr[k][7] * _u1(i + 1, j, nz - 8) +
                phdzr[k][6] * _u1(i + 1, j, nz - 7) +
                phdzr[k][5] * _u1(i + 1, j, nz - 6) +
                phdzr[k][4] * _u1(i + 1, j, nz - 5) +
                phdzr[k][3] * _u1(i + 1, j, nz - 4) +
                phdzr[k][2] * _u1(i + 1, j, nz - 3) +
                phdzr[k][1] * _u1(i + 1, j, nz - 2) +
                phdzr[k][0] * _u1(i + 1, j, nz - 1)) +
           px[3] * _f1_1(i + 2, j) *
               (phdzr[k][8] * _u1(i + 2, j, nz - 9) +
                phdzr[k][7] * _u1(i + 2, j, nz - 8) +
                phdzr[k][6] * _u1(i + 2, j, nz - 7) +
                phdzr[k][5] * _u1(i + 2, j, nz - 6) +
                phdzr[k][4] * _u1(i + 2, j, nz - 5) +
                phdzr[k][3] * _u1(i + 2, j, nz - 4) +
                phdzr[k][2] * _u1(i + 2, j, nz - 3) +
                phdzr[k][1] * _u1(i + 2, j, nz - 2) +
                phdzr[k][0] * _u1(i + 2, j, nz - 1)));
  float f_dcrj = _dcrjx(i) * _dcrjy(j) * _dcrjz(nz - 1 - k);
  _s11(i, j, nz - 1 - k) = (a * _s11(i, j, nz - 1 - k) + lam * div +
                            twomu * (dx[1] * _u1(i, j, nz - 1 - k) +
                                     dx[0] * _u1(i - 1, j, nz - 1 - k) +
                                     dx[2] * _u1(i + 1, j, nz - 1 - k) +
                                     dx[3] * _u1(i + 2, j, nz - 1 - k)) -
                            twomu * Jii * _g_c(nz - 1 - k) *
                                (px[1] * _f1_1(i, j) *
                                     (phdzr[k][8] * _u1(i, j, nz - 9) +
                                      phdzr[k][7] * _u1(i, j, nz - 8) +
                                      phdzr[k][6] * _u1(i, j, nz - 7) +
                                      phdzr[k][5] * _u1(i, j, nz - 6) +
                                      phdzr[k][4] * _u1(i, j, nz - 5) +
                                      phdzr[k][3] * _u1(i, j, nz - 4) +
                                      phdzr[k][2] * _u1(i, j, nz - 3) +
                                      phdzr[k][1] * _u1(i, j, nz - 2) +
                                      phdzr[k][0] * _u1(i, j, nz - 1)) +
                                 px[0] * _f1_1(i - 1, j) *
                                     (phdzr[k][8] * _u1(i - 1, j, nz - 9) +
                                      phdzr[k][7] * _u1(i - 1, j, nz - 8) +
                                      phdzr[k][6] * _u1(i - 1, j, nz - 7) +
                                      phdzr[k][5] * _u1(i - 1, j, nz - 6) +
                                      phdzr[k][4] * _u1(i - 1, j, nz - 5) +
                                      phdzr[k][3] * _u1(i - 1, j, nz - 4) +
                                      phdzr[k][2] * _u1(i - 1, j, nz - 3) +
                                      phdzr[k][1] * _u1(i - 1, j, nz - 2) +
                                      phdzr[k][0] * _u1(i - 1, j, nz - 1)) +
                                 px[2] * _f1_1(i + 1, j) *
                                     (phdzr[k][8] * _u1(i + 1, j, nz - 9) +
                                      phdzr[k][7] * _u1(i + 1, j, nz - 8) +
                                      phdzr[k][6] * _u1(i + 1, j, nz - 7) +
                                      phdzr[k][5] * _u1(i + 1, j, nz - 6) +
                                      phdzr[k][4] * _u1(i + 1, j, nz - 5) +
                                      phdzr[k][3] * _u1(i + 1, j, nz - 4) +
                                      phdzr[k][2] * _u1(i + 1, j, nz - 3) +
                                      phdzr[k][1] * _u1(i + 1, j, nz - 2) +
                                      phdzr[k][0] * _u1(i + 1, j, nz - 1)) +
                                 px[3] * _f1_1(i + 2, j) *
                                     (phdzr[k][8] * _u1(i + 2, j, nz - 9) +
                                      phdzr[k][7] * _u1(i + 2, j, nz - 8) +
                                      phdzr[k][6] * _u1(i + 2, j, nz - 7) +
                                      phdzr[k][5] * _u1(i + 2, j, nz - 6) +
                                      phdzr[k][4] * _u1(i + 2, j, nz - 5) +
                                      phdzr[k][3] * _u1(i + 2, j, nz - 4) +
                                      phdzr[k][2] * _u1(i + 2, j, nz - 3) +
                                      phdzr[k][1] * _u1(i + 2, j, nz - 2) +
                                      phdzr[k][0] * _u1(i + 2, j, nz - 1)))) *
                           f_dcrj;
  _s22(i, j, nz - 1 - k) = (a * _s22(i, j, nz - 1 - k) + lam * div +
                            twomu * (dhy[2] * _u2(i, j, nz - 1 - k) +
                                     dhy[0] * _u2(i, j - 2, nz - 1 - k) +
                                     dhy[1] * _u2(i, j - 1, nz - 1 - k) +
                                     dhy[3] * _u2(i, j + 1, nz - 1 - k)) -
                            twomu * Jii * _g_c(nz - 1 - k) *
                                (phy[2] * _f2_2(i, j) *
                                     (phdzr[k][8] * _u2(i, j, nz - 9) +
                                      phdzr[k][7] * _u2(i, j, nz - 8) +
                                      phdzr[k][6] * _u2(i, j, nz - 7) +
                                      phdzr[k][5] * _u2(i, j, nz - 6) +
                                      phdzr[k][4] * _u2(i, j, nz - 5) +
                                      phdzr[k][3] * _u2(i, j, nz - 4) +
                                      phdzr[k][2] * _u2(i, j, nz - 3) +
                                      phdzr[k][1] * _u2(i, j, nz - 2) +
                                      phdzr[k][0] * _u2(i, j, nz - 1)) +
                                 phy[0] * _f2_2(i, j - 2) *
                                     (phdzr[k][8] * _u2(i, j - 2, nz - 9) +
                                      phdzr[k][7] * _u2(i, j - 2, nz - 8) +
                                      phdzr[k][6] * _u2(i, j - 2, nz - 7) +
                                      phdzr[k][5] * _u2(i, j - 2, nz - 6) +
                                      phdzr[k][4] * _u2(i, j - 2, nz - 5) +
                                      phdzr[k][3] * _u2(i, j - 2, nz - 4) +
                                      phdzr[k][2] * _u2(i, j - 2, nz - 3) +
                                      phdzr[k][1] * _u2(i, j - 2, nz - 2) +
                                      phdzr[k][0] * _u2(i, j - 2, nz - 1)) +
                                 phy[1] * _f2_2(i, j - 1) *
                                     (phdzr[k][8] * _u2(i, j - 1, nz - 9) +
                                      phdzr[k][7] * _u2(i, j - 1, nz - 8) +
                                      phdzr[k][6] * _u2(i, j - 1, nz - 7) +
                                      phdzr[k][5] * _u2(i, j - 1, nz - 6) +
                                      phdzr[k][4] * _u2(i, j - 1, nz - 5) +
                                      phdzr[k][3] * _u2(i, j - 1, nz - 4) +
                                      phdzr[k][2] * _u2(i, j - 1, nz - 3) +
                                      phdzr[k][1] * _u2(i, j - 1, nz - 2) +
                                      phdzr[k][0] * _u2(i, j - 1, nz - 1)) +
                                 phy[3] * _f2_2(i, j + 1) *
                                     (phdzr[k][8] * _u2(i, j + 1, nz - 9) +
                                      phdzr[k][7] * _u2(i, j + 1, nz - 8) +
                                      phdzr[k][6] * _u2(i, j + 1, nz - 7) +
                                      phdzr[k][5] * _u2(i, j + 1, nz - 6) +
                                      phdzr[k][4] * _u2(i, j + 1, nz - 5) +
                                      phdzr[k][3] * _u2(i, j + 1, nz - 4) +
                                      phdzr[k][2] * _u2(i, j + 1, nz - 3) +
                                      phdzr[k][1] * _u2(i, j + 1, nz - 2) +
                                      phdzr[k][0] * _u2(i, j + 1, nz - 1)))) *
                           f_dcrj;
  _s33(i, j, nz - 1 - k) =
      (a * _s33(i, j, nz - 1 - k) + lam * div +
       twomu * Jii *
           (dhzr[k][7] * _u3(i, j, nz - 8) + dhzr[k][6] * _u3(i, j, nz - 7) +
            dhzr[k][5] * _u3(i, j, nz - 6) + dhzr[k][4] * _u3(i, j, nz - 5) +
            dhzr[k][3] * _u3(i, j, nz - 4) + dhzr[k][2] * _u3(i, j, nz - 3) +
            dhzr[k][1] * _u3(i, j, nz - 2) + dhzr[k][0] * _u3(i, j, nz - 1))) *
      f_dcrj;
  _s12(i, j, nz - 1 - k) =
      (a * _s12(i, j, nz - 1 - k) +
       mu12 *
           (dhx[2] * _u2(i, j, nz - 1 - k) +
            dhx[0] * _u2(i - 2, j, nz - 1 - k) +
            dhx[1] * _u2(i - 1, j, nz - 1 - k) +
            dhx[3] * _u2(i + 1, j, nz - 1 - k) + dy[1] * _u1(i, j, nz - 1 - k) +
            dy[0] * _u1(i, j - 1, nz - 1 - k) +
            dy[2] * _u1(i, j + 1, nz - 1 - k) +
            dy[3] * _u1(i, j + 2, nz - 1 - k) -
            J12i * _g_c(nz - 1 - k) *
                (phx[2] * _f1_2(i, j) *
                     (phdzr[k][8] * _u2(i, j, nz - 9) +
                      phdzr[k][7] * _u2(i, j, nz - 8) +
                      phdzr[k][6] * _u2(i, j, nz - 7) +
                      phdzr[k][5] * _u2(i, j, nz - 6) +
                      phdzr[k][4] * _u2(i, j, nz - 5) +
                      phdzr[k][3] * _u2(i, j, nz - 4) +
                      phdzr[k][2] * _u2(i, j, nz - 3) +
                      phdzr[k][1] * _u2(i, j, nz - 2) +
                      phdzr[k][0] * _u2(i, j, nz - 1)) +
                 phx[0] * _f1_2(i - 2, j) *
                     (phdzr[k][8] * _u2(i - 2, j, nz - 9) +
                      phdzr[k][7] * _u2(i - 2, j, nz - 8) +
                      phdzr[k][6] * _u2(i - 2, j, nz - 7) +
                      phdzr[k][5] * _u2(i - 2, j, nz - 6) +
                      phdzr[k][4] * _u2(i - 2, j, nz - 5) +
                      phdzr[k][3] * _u2(i - 2, j, nz - 4) +
                      phdzr[k][2] * _u2(i - 2, j, nz - 3) +
                      phdzr[k][1] * _u2(i - 2, j, nz - 2) +
                      phdzr[k][0] * _u2(i - 2, j, nz - 1)) +
                 phx[1] * _f1_2(i - 1, j) *
                     (phdzr[k][8] * _u2(i - 1, j, nz - 9) +
                      phdzr[k][7] * _u2(i - 1, j, nz - 8) +
                      phdzr[k][6] * _u2(i - 1, j, nz - 7) +
                      phdzr[k][5] * _u2(i - 1, j, nz - 6) +
                      phdzr[k][4] * _u2(i - 1, j, nz - 5) +
                      phdzr[k][3] * _u2(i - 1, j, nz - 4) +
                      phdzr[k][2] * _u2(i - 1, j, nz - 3) +
                      phdzr[k][1] * _u2(i - 1, j, nz - 2) +
                      phdzr[k][0] * _u2(i - 1, j, nz - 1)) +
                 phx[3] * _f1_2(i + 1, j) *
                     (phdzr[k][8] * _u2(i + 1, j, nz - 9) +
                      phdzr[k][7] * _u2(i + 1, j, nz - 8) +
                      phdzr[k][6] * _u2(i + 1, j, nz - 7) +
                      phdzr[k][5] * _u2(i + 1, j, nz - 6) +
                      phdzr[k][4] * _u2(i + 1, j, nz - 5) +
                      phdzr[k][3] * _u2(i + 1, j, nz - 4) +
                      phdzr[k][2] * _u2(i + 1, j, nz - 3) +
                      phdzr[k][1] * _u2(i + 1, j, nz - 2) +
                      phdzr[k][0] * _u2(i + 1, j, nz - 1))) -
            J12i * _g_c(nz - 1 - k) *
                (py[1] * _f2_1(i, j) *
                     (phdzr[k][8] * _u1(i, j, nz - 9) +
                      phdzr[k][7] * _u1(i, j, nz - 8) +
                      phdzr[k][6] * _u1(i, j, nz - 7) +
                      phdzr[k][5] * _u1(i, j, nz - 6) +
                      phdzr[k][4] * _u1(i, j, nz - 5) +
                      phdzr[k][3] * _u1(i, j, nz - 4) +
                      phdzr[k][2] * _u1(i, j, nz - 3) +
                      phdzr[k][1] * _u1(i, j, nz - 2) +
                      phdzr[k][0] * _u1(i, j, nz - 1)) +
                 py[0] * _f2_1(i, j - 1) *
                     (phdzr[k][8] * _u1(i, j - 1, nz - 9) +
                      phdzr[k][7] * _u1(i, j - 1, nz - 8) +
                      phdzr[k][6] * _u1(i, j - 1, nz - 7) +
                      phdzr[k][5] * _u1(i, j - 1, nz - 6) +
                      phdzr[k][4] * _u1(i, j - 1, nz - 5) +
                      phdzr[k][3] * _u1(i, j - 1, nz - 4) +
                      phdzr[k][2] * _u1(i, j - 1, nz - 3) +
                      phdzr[k][1] * _u1(i, j - 1, nz - 2) +
                      phdzr[k][0] * _u1(i, j - 1, nz - 1)) +
                 py[2] * _f2_1(i, j + 1) *
                     (phdzr[k][8] * _u1(i, j + 1, nz - 9) +
                      phdzr[k][7] * _u1(i, j + 1, nz - 8) +
                      phdzr[k][6] * _u1(i, j + 1, nz - 7) +
                      phdzr[k][5] * _u1(i, j + 1, nz - 6) +
                      phdzr[k][4] * _u1(i, j + 1, nz - 5) +
                      phdzr[k][3] * _u1(i, j + 1, nz - 4) +
                      phdzr[k][2] * _u1(i, j + 1, nz - 3) +
                      phdzr[k][1] * _u1(i, j + 1, nz - 2) +
                      phdzr[k][0] * _u1(i, j + 1, nz - 1)) +
                 py[3] * _f2_1(i, j + 2) *
                     (phdzr[k][8] * _u1(i, j + 2, nz - 9) +
                      phdzr[k][7] * _u1(i, j + 2, nz - 8) +
                      phdzr[k][6] * _u1(i, j + 2, nz - 7) +
                      phdzr[k][5] * _u1(i, j + 2, nz - 6) +
                      phdzr[k][4] * _u1(i, j + 2, nz - 5) +
                      phdzr[k][3] * _u1(i, j + 2, nz - 4) +
                      phdzr[k][2] * _u1(i, j + 2, nz - 3) +
                      phdzr[k][1] * _u1(i, j + 2, nz - 2) +
                      phdzr[k][0] * _u1(i, j + 2, nz - 1))))) *
      f_dcrj;
  _s13(i, j, nz - 1 - k) =
      (a * _s13(i, j, nz - 1 - k) +
       mu13 *
           (dhx[2] * _u3(i, j, nz - 1 - k) +
            dhx[0] * _u3(i - 2, j, nz - 1 - k) +
            dhx[1] * _u3(i - 1, j, nz - 1 - k) +
            dhx[3] * _u3(i + 1, j, nz - 1 - k) +
            J13i *
                (dzr[k][6] * _u1(i, j, nz - 7) + dzr[k][5] * _u1(i, j, nz - 6) +
                 dzr[k][4] * _u1(i, j, nz - 5) + dzr[k][3] * _u1(i, j, nz - 4) +
                 dzr[k][2] * _u1(i, j, nz - 3) + dzr[k][1] * _u1(i, j, nz - 2) +
                 dzr[k][0] * _u1(i, j, nz - 1)) -
            J13i * _g(nz - 1 - k) *
                (phx[2] * _f1_c(i, j) *
                     (pdhzr[k][8] * _u3(i, j, nz - 9) +
                      pdhzr[k][7] * _u3(i, j, nz - 8) +
                      pdhzr[k][6] * _u3(i, j, nz - 7) +
                      pdhzr[k][5] * _u3(i, j, nz - 6) +
                      pdhzr[k][4] * _u3(i, j, nz - 5) +
                      pdhzr[k][3] * _u3(i, j, nz - 4) +
                      pdhzr[k][2] * _u3(i, j, nz - 3) +
                      pdhzr[k][1] * _u3(i, j, nz - 2) +
                      pdhzr[k][0] * _u3(i, j, nz - 1)) +
                 phx[0] * _f1_c(i - 2, j) *
                     (pdhzr[k][8] * _u3(i - 2, j, nz - 9) +
                      pdhzr[k][7] * _u3(i - 2, j, nz - 8) +
                      pdhzr[k][6] * _u3(i - 2, j, nz - 7) +
                      pdhzr[k][5] * _u3(i - 2, j, nz - 6) +
                      pdhzr[k][4] * _u3(i - 2, j, nz - 5) +
                      pdhzr[k][3] * _u3(i - 2, j, nz - 4) +
                      pdhzr[k][2] * _u3(i - 2, j, nz - 3) +
                      pdhzr[k][1] * _u3(i - 2, j, nz - 2) +
                      pdhzr[k][0] * _u3(i - 2, j, nz - 1)) +
                 phx[1] * _f1_c(i - 1, j) *
                     (pdhzr[k][8] * _u3(i - 1, j, nz - 9) +
                      pdhzr[k][7] * _u3(i - 1, j, nz - 8) +
                      pdhzr[k][6] * _u3(i - 1, j, nz - 7) +
                      pdhzr[k][5] * _u3(i - 1, j, nz - 6) +
                      pdhzr[k][4] * _u3(i - 1, j, nz - 5) +
                      pdhzr[k][3] * _u3(i - 1, j, nz - 4) +
                      pdhzr[k][2] * _u3(i - 1, j, nz - 3) +
                      pdhzr[k][1] * _u3(i - 1, j, nz - 2) +
                      pdhzr[k][0] * _u3(i - 1, j, nz - 1)) +
                 phx[3] * _f1_c(i + 1, j) *
                     (pdhzr[k][8] * _u3(i + 1, j, nz - 9) +
                      pdhzr[k][7] * _u3(i + 1, j, nz - 8) +
                      pdhzr[k][6] * _u3(i + 1, j, nz - 7) +
                      pdhzr[k][5] * _u3(i + 1, j, nz - 6) +
                      pdhzr[k][4] * _u3(i + 1, j, nz - 5) +
                      pdhzr[k][3] * _u3(i + 1, j, nz - 4) +
                      pdhzr[k][2] * _u3(i + 1, j, nz - 3) +
                      pdhzr[k][1] * _u3(i + 1, j, nz - 2) +
                      pdhzr[k][0] * _u3(i + 1, j, nz - 1))))) *
      f_dcrj;
  _s23(i, j, nz - 1 - k) =
      (a * _s23(i, j, nz - 1 - k) +
       mu23 *
           (dy[1] * _u3(i, j, nz - 1 - k) + dy[0] * _u3(i, j - 1, nz - 1 - k) +
            dy[2] * _u3(i, j + 1, nz - 1 - k) +
            dy[3] * _u3(i, j + 2, nz - 1 - k) +
            J23i *
                (dzr[k][6] * _u2(i, j, nz - 7) + dzr[k][5] * _u2(i, j, nz - 6) +
                 dzr[k][4] * _u2(i, j, nz - 5) + dzr[k][3] * _u2(i, j, nz - 4) +
                 dzr[k][2] * _u2(i, j, nz - 3) + dzr[k][1] * _u2(i, j, nz - 2) +
                 dzr[k][0] * _u2(i, j, nz - 1)) -
            J23i * _g(nz - 1 - k) *
                (py[1] * _f2_c(i, j) *
                     (pdhzr[k][8] * _u3(i, j, nz - 9) +
                      pdhzr[k][7] * _u3(i, j, nz - 8) +
                      pdhzr[k][6] * _u3(i, j, nz - 7) +
                      pdhzr[k][5] * _u3(i, j, nz - 6) +
                      pdhzr[k][4] * _u3(i, j, nz - 5) +
                      pdhzr[k][3] * _u3(i, j, nz - 4) +
                      pdhzr[k][2] * _u3(i, j, nz - 3) +
                      pdhzr[k][1] * _u3(i, j, nz - 2) +
                      pdhzr[k][0] * _u3(i, j, nz - 1)) +
                 py[0] * _f2_c(i, j - 1) *
                     (pdhzr[k][8] * _u3(i, j - 1, nz - 9) +
                      pdhzr[k][7] * _u3(i, j - 1, nz - 8) +
                      pdhzr[k][6] * _u3(i, j - 1, nz - 7) +
                      pdhzr[k][5] * _u3(i, j - 1, nz - 6) +
                      pdhzr[k][4] * _u3(i, j - 1, nz - 5) +
                      pdhzr[k][3] * _u3(i, j - 1, nz - 4) +
                      pdhzr[k][2] * _u3(i, j - 1, nz - 3) +
                      pdhzr[k][1] * _u3(i, j - 1, nz - 2) +
                      pdhzr[k][0] * _u3(i, j - 1, nz - 1)) +
                 py[2] * _f2_c(i, j + 1) *
                     (pdhzr[k][8] * _u3(i, j + 1, nz - 9) +
                      pdhzr[k][7] * _u3(i, j + 1, nz - 8) +
                      pdhzr[k][6] * _u3(i, j + 1, nz - 7) +
                      pdhzr[k][5] * _u3(i, j + 1, nz - 6) +
                      pdhzr[k][4] * _u3(i, j + 1, nz - 5) +
                      pdhzr[k][3] * _u3(i, j + 1, nz - 4) +
                      pdhzr[k][2] * _u3(i, j + 1, nz - 3) +
                      pdhzr[k][1] * _u3(i, j + 1, nz - 2) +
                      pdhzr[k][0] * _u3(i, j + 1, nz - 1)) +
                 py[3] * _f2_c(i, j + 2) *
                     (pdhzr[k][8] * _u3(i, j + 2, nz - 9) +
                      pdhzr[k][7] * _u3(i, j + 2, nz - 8) +
                      pdhzr[k][6] * _u3(i, j + 2, nz - 7) +
                      pdhzr[k][5] * _u3(i, j + 2, nz - 6) +
                      pdhzr[k][4] * _u3(i, j + 2, nz - 5) +
                      pdhzr[k][3] * _u3(i, j + 2, nz - 4) +
                      pdhzr[k][2] * _u3(i, j + 2, nz - 3) +
                      pdhzr[k][1] * _u3(i, j + 2, nz - 2) +
                      pdhzr[k][0] * _u3(i, j + 2, nz - 1))))) *
      f_dcrj;
#undef _f_c
#undef _g3_c
#undef _f
#undef _f_1
#undef _g3
#undef _f_2
#undef _lami
#undef _mui
#undef _u2
#undef _f2_2
#undef _u3
#undef _g_c
#undef _f1_1
#undef _u1
#undef _dcrjx
#undef _dcrjz
#undef _dcrjy
#undef _s11
#undef _s22
#undef _s33
#undef _f1_2
#undef _f2_1
#undef _s12
#undef _g
#undef _s13
#undef _f1_c
#undef _s23
#undef _f2_c
}

__global__ void dtopo_init_material_111(float *lami, float *mui, float *rho,
                                        const int nx, const int ny,
                                        const int nz) {
  const int i = threadIdx.x + blockIdx.x * blockDim.x;
  if (i >= nx)
    return;
  const int j = threadIdx.y + blockIdx.y * blockDim.y;
  if (j >= ny)
    return;
  const int k = threadIdx.z + blockIdx.z * blockDim.z;
  if (k >= nz)
    return;
#define _rho(i, j, k) rho[(i)*ny * nz + (j)*nz + (k)]
#define _lami(i, j, k) lami[(i)*ny * nz + (j)*nz + (k)]
#define _mui(i, j, k) mui[(i)*ny * nz + (j)*nz + (k)]
  _rho(i, j, k) = 1.0;
  _lami(i, j, k) = 1.0;
  _mui(i, j, k) = 1.0;
#undef _rho
#undef _lami
#undef _mui
}
