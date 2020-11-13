program main
  use m_HACApK_calc_entry_ij
  implicit none
  integer :: i, j, nmax, ndim, ntrain
  real*8,dimension(:,:),allocatable :: k1

  ntrain = 10
  zbemv%p_sigma = 1.0d+3
  zbemv%p_delta = 1.0d-0

  open(1, file="Xtrain_MNIST.txt")
  read(1,*) nmax, ndim
  allocate(zbemv%data(ndim,ntrain))
  do i = 1, ntrain
    read(1,*) (zbemv%data(j,i), j = 1, ndim)
  end do
  
  zbemv%ndim=ndim
  allocate (k1(ntrain,ntrain))

  do j = 1, ntrain
    do i = 1, ntrain
      k1(i,j) = HACApK_entry_ij(i, j)
    end do
    print "(10es11.2)",k1(:,j)
  end do

end program


