#include <cstdio>

extern "C" double m_hacapk_calc_entry_ij_mp_hacapk_entry_ij_(int&, int&);

extern "C" void hicma_() {
  double k1[10][10];
  for(int i=0; i<10; i++) {
    for(int j=0; j<10; j++) {
      int I = i+1, J = j+1;
      k1[i][j] = m_hacapk_calc_entry_ij_mp_hacapk_entry_ij_(I, J);
      printf("%6.2e ",k1[i][j]);
    }
    printf("\n");
  }
}