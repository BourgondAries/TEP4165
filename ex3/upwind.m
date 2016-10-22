% 2d)
function result = upwind(u, tb, nj, t0, c, tend)
	dx = 1/nj;
	dt = c*dx/u;
	nend = ceil(tend/dt);
	dt = tend/nend;
	c = u*dt/dx;

	for t = 1:nend
		t0(1:nj-1) = t0(1:nj-1) - c*(t0(2:nj) - t0(1:nj-1));
	end

	result = t0;
end
