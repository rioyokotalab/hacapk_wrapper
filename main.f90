program main
  use ifport
  use m_HACApK_calc_entry_ij
  implicit none
  integer :: i, j, nmax, ndim, ntrain, info
  real*8 :: Aij
  integer,dimension(:),allocatable :: ipiv
  real*8,dimension(:),allocatable :: b, x, x2

  ntrain = 10
  zbemv%p_sigma = 1.0d+3
  zbemv%p_delta = 1.0d-0

  allocate (ipiv(ntrain))
  allocate (b(ntrain),x(ntrain),x2(ntrain))

  open(1, file="Xtrain_MNIST.txt")
  read(1,*) nmax, ndim
  allocate(zbemv%data(ndim,ntrain))
  do i = 1, ntrain
    read(1,*) (zbemv%data(j,i), j = 1, ndim)
    x(i) = drand(0)
  end do
  
  zbemv%ndim=ndim

  do j = 1, ntrain
    b(j) = 0
    do i = 1, ntrain
      Aij = HACApK_entry_ij(i, j)
      b(j) = b(j) + Aij * x(i)
    end do
    x2(j) = b(j)
  end do
  call hicma(ntrain, x2);
  do i = 1, ntrain
    print*,i,x(i),x2(i)
  end do

end program


