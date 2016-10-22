program simple
	implicit none

	double precision :: width = 0.5, height = 0.2, dx = 0.01, dy = 0.01
	double precision :: a, b, q, tn = 250., ts = 350., te = 250., tw = 350., oldnorm, newnorm
	integer :: n, o, i, j, k
	logical :: is_done = .false.
	double precision, allocatable, dimension(:,:) :: h, coeff, h0, h1, hprev

	n = width/dx
	o = height/dy
	a = dy/dx
	b = dx/dy
	q = a+b

	allocate(h(n+2,o+2))
	allocate(h0(n+2,o+2))
	allocate(h1(n+2,o+2))
	allocate(hprev(n+2,o+2))
	allocate(coeff(n+2,o+2))

	h = 0
	coeff = 0

	coeff(2,3:o) = -(3./2.*a+2.*b)      ! Left
	coeff(n+1,3:o) = -(3./2.*a+2.*b)    ! Right
	coeff(3:n,2) = -(2.*a+3./2.*b)      ! Bottom
	coeff(3:n,o+1) = -(2.*a+3./2.*b)    ! Top

	coeff(3:n,3:o) = -2.*q              ! Internal nodes
	coeff(2,2) = -3./2.*q               ! Bottom left
	coeff(n+1,2) = -3./2.*q             ! Bottom right
	coeff(2,o+1) = -3./2.*q             ! Top left
	coeff(n+1,o+1) = -3./2.*q           ! Top right

	h(1,2:o+1) = 1./2.*tw   ! West
	h(2:n+1,1) = 1./2.*ts   ! South
	h(n+2,2:o+1) = 1./2.*te ! East
	h(2:n+1,o+2) = 1./2.*tn ! North

	k = 0

	do while (.not. is_done)

		do j=2,o+1
			do i=2,n+1
				h(i,j) = 1./coeff(i,j)*(-b*h(i,j-1)-a*h(i-1,j)-b*h(i,j+1)-a*h(i+1,j))
			end do
		end do

		if (k .eq. 0) then
			h0 = h
		elseif (k .eq. 1) then
			h1 = h
			oldnorm = 1e-6*sqrt(dx*dy*sum((h1-h0)**2))
			hprev = h
		else
			newnorm = sqrt(dx*dy*sum((h-hprev)**2))
			if (newnorm .lt. oldnorm) then
				is_done = .true.
			else
				hprev = h
			end if
		end if

		k = k+1

		if (is_done) then
			write(*,*) 'Did ', k, ' iterations'
		end if

	end do

	open(10,file='b.dat',status='unknown')

	do i = 2,n+1
		write(10,*) h(i,2:o+1)
	end do

	close(10)

	deallocate(coeff)
	deallocate(hprev)
	deallocate(h1)
	deallocate(h0)
	deallocate(h)

end program simple

