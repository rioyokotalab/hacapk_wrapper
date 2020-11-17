program main
  use ifport
  use m_HACApK_calc_entry_ij
  implicit none
  integer :: i, j, nmax, ndim, ntrain, info
  integer,dimension(:),allocatable :: ipiv
  real*8,dimension(:),allocatable :: b, x
  real*8,dimension(:,:),allocatable :: k1

  ntrain = 10
  zbemv%p_sigma = 1.0d+3
  zbemv%p_delta = 1.0d-0

  allocate (ipiv(ntrain))
  allocate (b(ntrain),x(ntrain))
  allocate (k1(ntrain,ntrain))

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
      k1(i,j) = HACApK_entry_ij(i, j)
      b(j) = b(j) + k1(i,j) * x(i)
    end do
    print*,j,b(j)
    print "(10es11.2)",k1(:,j)
  end do
  call dgetrf(ntrain, ntrain, k1, ntrain, ipiv, info)
  call dgetrs('N', ntrain, 1, k1, ntrain, ipiv, b, ntrain, info)
  do i = 1, ntrain
    print*,i,x(i),b(i)
  end do

end program


