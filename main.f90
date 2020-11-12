program main
use m_HACApK_calc_entry_ij
  implicit none
  integer :: i, j, nmax, nf, ntrain
  real*8,dimension(:,:),allocatable :: k1
  character*32 value
  character filename*256
  type(st_HACApK_calc_entry) :: st_bemv

  ntrain = 10
  st_bemv%p_sigma = 1.0d+3
  st_bemv%p_delta = 1.0d-0
  filename="Xtrain_MNIST.txt"

  open(1, file=filename)
  read(1,*) nmax, nf
  allocate(st_bemv%data(nf,ntrain))
  do i = 1, ntrain
    read(1,*) (st_bemv%data(j,i), j = 1, nf)
  end do
  
  st_bemv%ndim=nf
  allocate (k1(ntrain,ntrain))

  do j = 1, ntrain
    do i = 1, ntrain
      k1(i,j) = HACApK_entry_ij(i, j, st_bemv)
    end do
    print "(10es11.2)",k1(:,j)
  end do

end program


