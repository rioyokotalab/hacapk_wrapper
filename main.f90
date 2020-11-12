program mian
use m_HACApK_calc_entry_ij
  implicit none
  integer :: i,j,nmax, nf, ntrain
  integer :: nargs,nlength,nstatus,number
  real*8,dimension(:,:),allocatable :: k1
  character*32 value
  character filename*256
  type(st_HACApK_calc_entry) :: st_bemv
 3000 format(50(1pe11.2))

nargs=command_argument_count()
if(nargs==0)then
  ntrain =  10; print*, 'Number of data set; ntrain=100'
else
  number=1
  call get_command_argument(number,value,nlength,nstatus)
  if(value=="") then; else
    read(value,*) ntrain 
  endif
endif

  st_bemv%p_sigma = 1.0d+3   ! parameter for Gauss kernel
  st_bemv%p_delta = 1.0d-0   ! parameter for reguralization

  filename="./Xtrain_MNIST.txt"
  open(1, file=filename)
  read(1,*) nmax, nf
  allocate(st_bemv%data(nf,ntrain))
  do i = 1, ntrain
    read(1,*) (st_bemv%data(j,i), j = 1, nf)
  end do
  
  st_bemv%ndim=nf; st_bemv%nd=ntrain
  allocate (k1(ntrain,ntrain))

  do j = 1, ntrain
    do i = 1, ntrain
      k1(i,j) = HACApK_entry_ij(i, j, st_bemv)
    end do
    write(10,3000) k1(:,j)
  end do

end program


