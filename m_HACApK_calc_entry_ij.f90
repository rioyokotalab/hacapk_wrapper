module m_HACApK_calc_entry_ij

!*** type :: st_HACApK_calc_entry
  type :: st_HACApK_calc_entry
  
  real*8,pointer :: data(:,:)
  real*8 :: p_sigma,p_delta
  integer :: ndim

  end type st_HACApK_calc_entry

public :: HACApK_entry_ij

contains
!***HACApK_entry_ij
  real*8 function HACApK_entry_ij(i, j, zbemv)
  implicit real*8(a-h,o-z)
  type(st_HACApK_calc_entry) :: zbemv
  
  if(i==j) then
    HACApK_entry_ij=1.0d0; return
  endif
  
  ndim=zbemv%ndim; p_sigma=zbemv%p_sigma
  zaa=0.0d0
  do il=1,ndim
    zw=zbemv%data(il,i)-zbemv%data(il,j)
    zaa=zaa+zw*zw
  enddo
  
  zzz=1.0d0+sqrt(zbemv%p_delta)
  HACApK_entry_ij=exp(-zaa/(2.0d0*p_sigma**2))/zzz

end function HACApK_entry_ij

endmodule m_HACApK_calc_entry_ij
