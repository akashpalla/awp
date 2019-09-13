//Auto-generated by OpenFD
#include "kernel.h"

void diff_right(float *v, float *vh, const float *u, const float *uh, const float hi, const int n)
{
     const float dr[5][7] = {{0.0000000000000000, 2.3902417081575802, -5.7686635597644571, 4.3952586757899788, -1.0168368241831045, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.8266089824344796, -0.7832496503558544, -0.0844806869738186, 0.0411213548951934, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, -0.0681384442323802, 1.2463805394886265, -1.1135385931963100, -0.0647035020599357, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0024894753315249, -0.0650306538162435, 1.1579606841700389, -1.1398246280599089, 0.0444051223745890, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0416666666666667, 1.1250000000000000, -1.1250000000000000, 0.0416666666666667}};
     const float dhr[5][6] = {{0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {1.0806251566085985, -1.1361282133044561, 0.0578151993312359, -0.0023121426353782, 0.0000000000000000, 0.0000000000000000}, {-0.0722830896648016, 0.9802543837620807, -0.9629679489263054, 0.0549966548290263, 0.0000000000000000, 0.0000000000000000}, {-0.0312519117766921, 0.1358414259719470, 1.1053572346317724, -1.2581956510746815, 0.0482489022476542, 0.0000000000000000}, {0.0151844429723013, -0.0561685906239703, 0.0545602671281998, 1.0520677743115070, -1.1066301973952699, 0.0409863036072322}};
     for (int i = 0; i < 5; ++i) {
          #define _(i) [(i)]
          #define _uh(i) uh[(i)]
          #define _u(i) u[(i)]
          #define _v(i) v[(i)]
          #define _vh(i) vh[(i)]
          _v(n - 1 - i) = hi*(dr[i][6]*_uh(n - 7) + dr[i][5]*_uh(n - 6) + dr[i][4]*_uh(n - 5) + dr[i][3]*_uh(n - 4) + dr[i][2]*_uh(n - 3) + dr[i][1]*_uh(n - 2) + dr[i][0]*_uh(n - 1));
          _vh(n - 1 - i) = hi*(dhr[i][5]*_u(n - 6) + dhr[i][4]*_u(n - 5) + dhr[i][3]*_u(n - 4) + dhr[i][2]*_u(n - 3) + dhr[i][1]*_u(n - 2) + dhr[i][0]*_u(n - 1));
          #undef _
          #undef _uh
          #undef _u
          #undef _v
          #undef _vh
          
     }
     
}

void diff_left(float *v, float *vh, const float *u, const float *uh, const float hi, const int n)
{
     const float dl[4][5] = {{-2.3902417081575802, 5.7686635597644571, -4.3952586757899788, 1.0168368241831045, 0.0000000000000000}, {-0.8266089824344796, 0.7832496503558544, 0.0844806869738186, -0.0411213548951934, 0.0000000000000000}, {0.0681384442323802, -1.2463805394886265, 1.1135385931963100, 0.0647035020599357, 0.0000000000000000}, {-0.0024894753315249, 0.0650306538162435, -1.1579606841700389, 1.1398246280599089, -0.0444051223745890}};
     const float dhl[4][6] = {{-1.0806251566085985, 1.1361282133044561, -0.0578151993312359, 0.0023121426353782, 0.0000000000000000, 0.0000000000000000}, {0.0722830896648016, -0.9802543837620807, 0.9629679489263054, -0.0549966548290263, 0.0000000000000000, 0.0000000000000000}, {0.0312519117766921, -0.1358414259719470, -1.1053572346317724, 1.2581956510746815, -0.0482489022476542, 0.0000000000000000}, {-0.0151844429723013, 0.0561685906239703, -0.0545602671281998, -1.0520677743115070, 1.1066301973952699, -0.0409863036072322}};
     for (int i = 0; i < 4; ++i) {
          #define _uh(i) uh[(i)]
          #define _u(i) u[(i)]
          #define _v(i) v[(i)]
          #define _vh(i) vh[(i)]
          _v(i) = hi*(dl[i][0]*_uh(0) + dl[i][1]*_uh(1) + dl[i][2]*_uh(2) + dl[i][3]*_uh(3) + dl[i][4]*_uh(4));
          _vh(i) = hi*(dhl[i][0]*_u(0) + dhl[i][1]*_u(1) + dhl[i][2]*_u(2) + dhl[i][3]*_u(3) + dhl[i][4]*_u(4) + dhl[i][5]*_u(5));
          #undef _uh
          #undef _u
          #undef _v
          #undef _vh
          
     }
     
}

void diff_interior(float *v, float *vh, const float *u, const float *uh, const float hi, const int n)
{
     const float d[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     const float dh[4] = {0.0416666666666667, -1.1250000000000000, 1.1250000000000000, -0.0416666666666667};
     for (int i = 0; i < n - 9; ++i) {
          #define _uh(i) uh[(i)]
          #define _u(i) u[(i)]
          #define _v(i) v[(i)]
          #define _vh(i) vh[(i)]
          _v(i + 4) = hi*(d[0]*_uh(i + 2) + d[1]*_uh(i + 3) + d[2]*_uh(i + 4) + d[3]*_uh(i + 5));
          _vh(i + 4) = hi*(dh[0]*_u(i + 3) + dh[1]*_u(i + 4) + dh[2]*_u(i + 5) + dh[3]*_u(i + 6));
          #undef _uh
          #undef _u
          #undef _v
          #undef _vh
          
     }
     
}

void interp_right(float *v, float *vh, const float *u, const float *uh, const int n)
{
     const float pr[5][6] = {{0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000, 0.0000000000000000}, {0.1432925140311146, 1.0598132016300112, 0.0221423116621912, -0.2252480273233170, 0.0000000000000000, 0.0000000000000000}, {0.0274810429525026, 0.5809932828438779, 0.2693108269309878, 0.1222148472726317, 0.0000000000000000, 0.0000000000000000}, {-0.0709195781064454, -0.0904916019032780, 0.7925525444384850, 0.4345882402054228, -0.0657296046341844, 0.0000000000000000}, {0.0341159552601544, -0.0058323162735341, -0.1372116399206229, 0.6101695830109228, 0.5611032201634648, -0.0623448022403850}};
     const float phr[5][7] = {{0.0000000000000000, 1.0184627230166077, 0.6156502671559684, -1.2866726737045093, 0.6525596835319332, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.4007777553422364, 0.6925077222206185, -0.0873499897554077, -0.0059354878074472, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, 0.0087699452861385, 0.3362071643610178, 0.8012762820481487, -0.1462533916953050, 0.0000000000000000, 0.0000000000000000}, {0.0000000000000000, -0.0821000395181595, 0.1404059670608126, 0.4043343506445254, 0.5985135556011494, -0.0611538337883279, 0.0000000000000000}, {0.0000000000000000, 0.0000000000000000, 0.0000000000000000, -0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000}};
     for (int i = 0; i < 5; ++i) {
          #define _(i) [(i)]
          #define _uh(i) uh[(i)]
          #define _u(i) u[(i)]
          #define _v(i) v[(i)]
          #define _vh(i) vh[(i)]
          _v(n - 1 - i) = pr[i][5]*_uh(n - 6) + pr[i][4]*_uh(n - 5) + pr[i][3]*_uh(n - 4) + pr[i][2]*_uh(n - 3) + pr[i][1]*_uh(n - 2) + pr[i][0]*_uh(n - 1);
          _vh(n - 1 - i) = phr[i][6]*_u(n - 7) + phr[i][5]*_u(n - 6) + phr[i][4]*_u(n - 5) + phr[i][3]*_u(n - 4) + phr[i][2]*_u(n - 3) + phr[i][1]*_u(n - 2) + phr[i][0]*_u(n - 1);
          #undef _
          #undef _uh
          #undef _u
          #undef _v
          #undef _vh
          
     }
     
}

void interp_left(float *v, float *vh, const float *u, const float *uh, const int n)
{
     const float pl[4][6] = {{0.1432925140311146, 1.0598132016300112, 0.0221423116621912, -0.2252480273233170, 0.0000000000000000, 0.0000000000000000}, {0.0274810429525026, 0.5809932828438779, 0.2693108269309878, 0.1222148472726317, 0.0000000000000000, 0.0000000000000000}, {-0.0709195781064454, -0.0904916019032780, 0.7925525444384850, 0.4345882402054228, -0.0657296046341844, 0.0000000000000000}, {0.0341159552601544, -0.0058323162735341, -0.1372116399206229, 0.6101695830109228, 0.5611032201634648, -0.0623448022403850}};
     const float phl[4][5] = {{1.0184627230166077, 0.6156502671559684, -1.2866726737045093, 0.6525596835319332, 0.0000000000000000}, {0.4007777553422364, 0.6925077222206185, -0.0873499897554077, -0.0059354878074472, 0.0000000000000000}, {0.0087699452861385, 0.3362071643610178, 0.8012762820481487, -0.1462533916953050, 0.0000000000000000}, {-0.0821000395181595, 0.1404059670608126, 0.4043343506445254, 0.5985135556011494, -0.0611538337883279}};
     for (int i = 0; i < 4; ++i) {
          #define _uh(i) uh[(i)]
          #define _u(i) u[(i)]
          #define _v(i) v[(i)]
          #define _vh(i) vh[(i)]
          _v(i) = pl[i][0]*_uh(0) + pl[i][1]*_uh(1) + pl[i][2]*_uh(2) + pl[i][3]*_uh(3) + pl[i][4]*_uh(4) + pl[i][5]*_uh(5);
          _vh(i) = phl[i][0]*_u(0) + phl[i][1]*_u(1) + phl[i][2]*_u(2) + phl[i][3]*_u(3) + phl[i][4]*_u(4);
          #undef _uh
          #undef _u
          #undef _v
          #undef _vh
          
     }
     
}

void interp_interior(float *v, float *vh, const float *u, const float *uh, const int n)
{
     const float p[4] = {-0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000};
     const float ph[4] = {-0.0625000000000000, 0.5625000000000000, 0.5625000000000000, -0.0625000000000000};
     for (int i = 0; i < n - 9; ++i) {
          #define _uh(i) uh[(i)]
          #define _u(i) u[(i)]
          #define _v(i) v[(i)]
          #define _vh(i) vh[(i)]
          _v(i + 4) = p[0]*_uh(i + 3) + p[1]*_uh(i + 4) + p[2]*_uh(i + 5) + p[3]*_uh(i + 6);
          _vh(i + 4) = ph[0]*_u(i + 2) + ph[1]*_u(i + 3) + ph[2]*_u(i + 4) + ph[3]*_u(i + 5);
          #undef _uh
          #undef _u
          #undef _v
          #undef _vh
          
     }
     
}
