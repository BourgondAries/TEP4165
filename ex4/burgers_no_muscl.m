% 2a)
% nj = number of cells
% u0 = initial condition of all cells
% v = viscosity
% tend = time end
function result = burgers_no_muscl(nj, u0, v, stability_bound, tend, intercal)
	dx = 1/nj;

	% If v is zero, then we can assume r is zero, so we must
	% extract the dt by using the definition of the stability bound
	% If v is not zero, then we simply use stability_bound = max(abs(u0))*dt/dx + 2*v*dt/dx/dx
	% => dt = stability_bound/(max(abs(u0))/dx + 2*v/dx/dx)
	% This case also works when v is zero!
	dt = stability_bound/(max(abs(u0))/dx + 2*v/dx/dx);

	nend = ceil(tend/dt);
	dt = tend/nend;

	u1 = u0;

	for i = 1:nend
		u1(2:nj-1) = u0(2:nj-1) - dt/dx*(...
			1/2*(u0(3:nj).^2/2 - abs(1/2*(u0(2:nj-1)+u0(3:nj))) .* (u0(3:nj) - u0(2:nj-1))) - ...
			1/2*(u0(1:nj-2).^2/2 - abs(1/2*(u0(1:nj-2)+u0(2:nj-1))) .* (u0(2:nj-1) - u0(1:nj-2))) - ...
			v*(u0(3:nj) - 2*u0(2:nj-1) + u0(1:nj-2))...
		);
		% Doing the left boundary
		u1(1) = u0(1) - dt/dx*(...
			1/2*(u0(2).^2/2 - abs(1/2*(u0(1)+u0(2))) * (u0(2) - u0(1))) - ...
			1/2*(u0(end).^2/2 - abs(1/2*(u0(end)+u0(1))) * (u0(1) - u0(end))) - ...
			v*(u0(2) - 2*u0(1) + u0(end))...
		);
		% And the right boundary
		u1(end) = u0(end) - dt/dx*(...
			1/2*(u0(1).^2/2 - abs(1/2*(u0(end)+u0(1))) * (u0(1) - u0(end))) - ...
			1/2*(u0(end-1).^2/2 - abs(1/2*(u0(end-1)+u0(end))) * (u0(end) - u0(end-1))) - ...
			v*(u0(1) - 2*u0(end) + u0(end-1))...
		);
		u0 = u1;

		% If we want to animate a plot
		intercal(nj, u0);
	end

	result = u0;

end
