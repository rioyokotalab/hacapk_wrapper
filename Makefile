.SUFFIXES: .o .f90 .cpp

HICMA_ROOT = $(HOME)/hicma

CXX=icpc
F90=ifort
CXXFLAGS = -fopenmp -O3 -ip -mkl -I$(HICMA_ROOT)/include
F90FLAGS = -fopenmp -O3 -ip -mkl -fpp
LDFLAGS = -mkl -lstdc++ -Wl,-rpath,${HICMA_ROOT}/dependencies/lib:${HICMA_ROOT}/lib ${HICMA_ROOT}/lib/libhicma.so -L${HICMA_ROOT}/lib -lhicma
OBJS = m_HACApK_calc_entry_ij.o main.o wrapper.o


main: $(OBJS)
	$(F90) $(OBJS) $(LDFLAGS)
	./a.out
h_lu: h_lu.o
	$(CXX) $? $(LDFLAGS)
	./a.out
.f90.o: *.f90
	$(F90) -c $< $(F90FLAGS)
.cpp.o: *.cpp
	$(CXX) -c $< $(CXXFLAGS)
clean:
	$(RM) *.mod *.o *.out
