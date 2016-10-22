clc; clear all; close all;

% Amount of cells
p = 100;
dx = 1/p;
area = pi*2*0.01*dx;
h = 80;

insulated = false;

% The matrix a:
a = diag(ones(p,1),1)+diag(ones(p,1),-1)-2*eye(p+1);
a(1,1) = -1;
a(1,2) = 2/3;
a(p+1,p+1) = -1;
a(p+1,p) = 2/3;

if ~insulated
	a = a - eye(p+1)*area*h;
end

% Vector b:
b = zeros(p+1,1);
b(1) = -1/3*573.15;
b(p+1) = -1/3*1273.15;

if ~insulated
	b = b - h*250*area;
end

% matrix d:
d = diag(diag(a));

% matrix r:
r = a - d;

% state x:
x = ones(p+1,1);

% Jacobi iteration:
% Optimization
id = inv(d);
exact = a\b;

% Plotting preparations
figure;
xlabel('position');
ylabel('temperature [K]');

for i = 1:30000
	x = id*(b-r*x);

	% Plotting
	if mod(i, 50) == 0
		plot(0:1/p:1,x);
		hold on;
		plot(0:1/p:1,exact);
		title(['Iteration: ' num2str(i)]);
		legend('Jacobi Iterate','Exact Solution');
		drawnow;
		hold off;
	end
end



