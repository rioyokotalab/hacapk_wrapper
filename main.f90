program main
use m_HACApK_calc_entry_ij
  implicit none
  integer :: i, j, nmax, ndim, ntrain
  real*8,dimension(:,:),allocatable :: k1
  type(st_HACApK_calc_entry) :: st_bemv

  ntrain = 10
  st_bemv%p_sigma = 1.0d+3
  st_bemv%p_delta = 1.0d-0

  open(1, file="Xtrain_MNIST.txt")
  read(1,*) nmax, ndim
  allocate(st_bemv%data(ndim,ntrain))
  do i = 1, ntrain
    read(1,*) (st_bemv%data(j,i), j = 1, ndim)
  end do
  
  st_bemv%ndim=ndim
  allocate (k1(ntrain,ntrain))

  do j = 1, ntrain
    do i = 1, ntrain
      k1(i,j) = HACApK_entry_ij(i, j, st_bemv)
    end do
    print "(10es11.2)",k1(:,j)
  end do

end program


