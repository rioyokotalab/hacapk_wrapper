#SYSTEM = FX10
SYSTEM = INTEL
#SYSTEM = XC30

#FX10
ifeq ($(SYSTEM),FX10)
OPTFLAGS = -fs
CC=mpifccpx
F90=mpifrtpx -Kfast,openmp
#F90=mpifrtpx -Kopenmp
CCFLAGS = $(OPTFLAGS)
F90FLAGS = $(OPTFLAGS) -Cfpp
LDFLAGS = -SSL2
endif

#intel
ifeq ($(SYSTEM),INTEL)
###OPTFLAGS = -O3 -traceback -ip -heap-arrays -qopenmp -mkl
OPTFLAGS = -qopenmp -O3 -ip -mkl
CC=mpiicc
F90=mpiifort
CCFLAGS = $(OPTFLAGS)
#F90FLAGS = $(OPTFLAGS) -fpp -assume nounderscore -names uppercase
###F90FLAGS = $(OPTFLAGS) -fpp -check all
F90FLAGS = $(OPTFLAGS) -fpp
#F90FLAGS = -fpe0 -traceback -g -CB -assume nounderscore -names lowercase -fpp -check all
#LDFLAGS = -mkl -trace
LDFLAGS = -mkl
endif

#XC30
ifeq ($(SYSTEM),XC30)
OPTFLAGS = -O2 -homp
CC=cc
F90=ftn
CCFLAGS = $(OPTFLAGS)
F90FLAGS = $(OPTFLAGS)
endif

LINK=$(F90)

OBJS= m_HACApK_calc_entry_ij.o main.o

.SUFFIXES: .o .f90

main: $(OBJS)
			$(LINK) $(OBJS) $(LDFLAGS)
.f90.o: *.f90
			$(F90) -c $< $(F90FLAGS)
clean:
	rm -f *.o *.mod $(TARGET)
