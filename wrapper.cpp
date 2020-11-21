#include "hicma/hicma.h"

#include <cstdio>
#include <vector>

using namespace hicma;

extern "C" double m_hacapk_calc_entry_ij_mp_hacapk_entry_ij_(int&, int&);

extern "C" void hicma_(int& N) {
  hicma::initialize();
  Dense A(N, N);
  for(int i=0; i<N; i++) {
    for(int j=0; j<N; j++) {
      int I = i+1, J = j+1;
      A(i,j) = m_hacapk_calc_entry_ij_mp_hacapk_entry_ij_(I, J);
      printf("%6.2e ",A(i,j));
    }
    printf("\n");
  }
}
