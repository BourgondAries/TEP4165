clc; clear all; close all;

init = @(x,y) 1.25-2.*x;  % Global initial condition
n = 100;  % Amount of points
for n = [20 40 80]
	c = n-1;  % Amount of cells
	dx = 1/n;

	u = repmat(init(0:1/c:1, 0)', 1, n);  % The initial matrix
	un = u;  % The next time step

	% Stability is given by |Cx| + |Cy| <= 1
	% => |u dt/dx| + |dt/dx| <= 1
	% => |125 dt| + |100 dt| <= 1
	% => 225 dt <= 1
	% => 225 <= 1/dt
	% => 1/225 >= dt
	%
	% In general:
	% => dt <= dx/2.25
	dt = dx/2.5;  % For good measure
	co = dt/dx;
	tend = 5;

	iter = ceil(tend/dt);
	dt = tend/iter;

	has_first = false;

	% Upwind Scheme:
	for i = 1:iter
		% Prepare the variables
		uxyt = u(2:end-1,n);
		uxym1t = u(2:end-1,n-1);
		uxm1yt = u(1:end-2,n);
		uxp1yt = u(3:end,n);

		uxy = u(2:end-1,2:end-1);
		uxym1 = u(2:end-1,1:end-2);
		uxm1y = u(1:end-2,2:end-1);
		uxm1ym1 = u(1:end-2,1:end-2);
		uxyp1 = u(2:end-1,3:end);
		uxp1y = u(3:end,2:end-1);
		uxp1yp1 = u(3:end,3:end);

		ma = max(uxy, 0);
		mi = min(uxy, 0);
		mat = max(uxyt, 0);
		mit = min(uxyt, 0);

		% Actual upwind code
		un(2:end-1,2:end-1) = uxy - co*(ma.*(uxy-uxm1y)+mi.*(uxp1y-uxy)) - co*(uxy-uxym1);
		un(2:end-1,n) = uxyt - co*(mat.*(uxyt-uxm1yt)+mit.*(uxp1yt-uxyt)) - co*(uxyt-uxym1t);

		% Norm checking
		if has_first == false
			first_norm = norm(un - u);
			has_first = true;
		elseif first_norm * 1e-6 >= norm(un - u)
			fprintf('Required %d iterations to converge\n', i);
			break;
		end
		surf(un);
		drawnow;

		% Getting ready for the next iteration
		u = un;
	end

	surf(un);
	xlabel('y');
	ylabel('x');

	figure;
	contour(un);
	xlabel('y');
	ylabel('x');
	input('Press enter to continue');
end
