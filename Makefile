.SUFFIXES: .o .f90 .cpp

HICMA_ROOT = $(HOME)/hicma

CXX=icpc
F90=ifort
CXXFLAGS = -qopenmp -O3 -ip -mkl -fpp
F90FLAGS = -qopenmp -O3 -ip -mkl -fpp
LDFLAGS = -mkl
OBJS = m_HACApK_calc_entry_ij.o main.o


main: $(OBJS)
	$(F90) $(OBJS) $(LDFLAGS)
	./a.out
.f90.o: *.f90
	$(F90) -c $< $(F90FLAGS)
.cpp.o: *.cpp
	$(CXX) -c $< $(CXXFLAGS)
clean:
	rm -f *.o *.mod $(TARGET)
