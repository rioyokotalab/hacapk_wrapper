#include "hicma/hicma.h"

#include <cstdio>
#include <vector>

using namespace hicma;

extern "C" double m_hacapk_calc_entry_ij_mp_hacapk_entry_ij_(int&, int&);

extern "C" void hicma_(int& N, double *x) {
  hicma::initialize();
  Dense A(N, N);
  Dense b(N);
  for(int i=0; i<N; i++) {
    b[i] = x[i];
    for(int j=0; j<N; j++) {
      int I = i+1, J = j+1;
      A(i,j) = m_hacapk_calc_entry_ij_mp_hacapk_entry_ij_(I, J);
    }
  }
  Dense L, U;
  std::tie(L, U) = getrf(A);
  trsm(L, b, TRSM_LOWER);
  trsm(U, b, TRSM_UPPER);
  for(int i=0; i<N; i++)
    x[i] = b[i];
}
