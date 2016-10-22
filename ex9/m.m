clc; clear all; close all;

w = 0.5;
height = 0.2;
dx = 0.01;
dy = 0.01;
n = w/dx;
o = height/dy;

a = dy/dx;
b = dx/dy;
q = a+b;

h = ones(n+2,o+2);
coeff = zeros(n+2,o+2);
coeff(2,2:end-1) = -(3/2*a+2*b);
coeff(end-1,2:end-1) = -(3/2*a+2*b);
coeff(2:end-1,2) = -(2*a+3/2*b);
coeff(2:end-1,end-1) = -(2*a+3/2*b);

coeff(3:end-2,3:end-2) = -2*q;
coeff(2,2) = -3/2*q;
coeff(end-1,2) = -3/2*q;
coeff(2,end-1) = -3/2*q;
coeff(end-1,end-1) = -3/2*q;

h(1,2:end-1) = 1/2*350;
h(2:end-1,1) = 1/2*350;
h(end,2:end-1) = 1/2*250;
h(2:end-1,end) = 1/2*250;

is_done = false;

k = 0;

while is_done == false

	for j = 2:o+1
		for i = 2:n+1
			h(i,j) = 1/coeff(i,j)*(-b*h(i,j-1)-a*h(i-1,j)-b*h(i,j+1)-a*h(i+1,j));
		end
	end

	if k == 0
		h0 = h;
	elseif k == 1
		h1 = h;
		oldnorm = 1e-6*sqrt(dx*dy*sum(sum((h1 - h0).^2)));
		hprev = h;
	else
		newnorm = sqrt(dx*dy*sum(sum((h - hprev).^2)));
		if newnorm < oldnorm
			is_done = true;
		else
			hprev = h;
		end
	end

	k = k+1;

	if is_done == true
		fprintf('Did %d iterations\n', k);
		break;
	end
end

h = rot90(h);
coeff = rot90(coeff);

contour(linspace(0,w,n),linspace(height,0,o),h(2:end-1,2:end-1),'ShowText','on');
xlabel('x');
ylabel('y');
title(['Temperature contour after ' num2str(k) ' iterations']);
