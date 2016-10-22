% 2b)
% Function solves the heat equation
function result = solve2(nj, t0, r, tend, alpha, t1, t2)
	dx = 1/nj;
	deltat = r/alpha*dx^2;
	tn = t0;

	for j = 0:deltat:tend
		for i = 2:numel(t0)-1
			tn(i) = t0(i) + r*(t0(i+1)-2*t0(i)+t0(i-1));
		end
		tn(1) = t0(1) + r*(t0(2)-3*t0(1)+2*t1);
		tn(nj) = t0(nj) + r*(t0(numel(t0)-1)-3*t0(numel(t0))+2*t2);
		t0 = tn;
	end
	result = tn;
end
