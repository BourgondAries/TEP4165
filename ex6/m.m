clc; clear all; close all;

% Reference values
nj = 100; ma = 2; gamma = 1.4;
rho_l = 1; u_l = sqrt(gamma)*ma;
rho_e_l = 1/(gamma-1)+1/2*gamma*ma^2;

% Creating the initial matrix
ul = repmat([1 sqrt(gamma)*ma 1/(gamma-1)+1/2*gamma*ma^2], [nj/2 1]);
ur = repmat([1*(1-2/(gamma+1)*(1-1/ma^2))^(-1) sqrt(gamma)*ma*(1-2/(gamma+1)*(1-1/ma^2)) (1/(gamma-1)+1/2*gamma*ma^2)*(1+2*gamma/(gamma+1)*(ma^2-1))], [nj/2 1]);

u = [ul; ur];
init = u;

% Finding the optimal Delta t
alpha = 0.25; dx = 1/nj; L = 1; pr = 0.75; re = 1;

mu_star = @(u) L*u(:,2)/re;

dt = alpha*dx/(max(abs(u(:, 2)./u(:,1)) + arfun(u,1,nj,@sound)) + 1/dx*2*max([4/3; gamma/pr])*max(mu_star(u)./u(1)));
fprintf('alpha = %d\n', alpha);
fprintf('dt = %d\n', dt);
fprintf('mu = %d\n', max(mu_star(u)));


% Computing the values (assuming dt is correct)
tend = 1;
nend = ceil(tend/dt);
dt = tend/nend;

vh = @(l,r)vhflux(l,r);
ch = @(l,r)chflux(l,r);
w = u;
for i = 1:nend
	for j = 2:size(u,1)-1
		l1 = u(j-1,:);
		l = u(j,:);
		r = u(j+1,:);
		w(j,:) = u(j,:)+dt/dx*(vh(l,r)-vh(l1,l)-(ch(l,r) - ch(l1,l)));
	end
	u = w;
end
plot(1:size(u,1), u(:,1));
title('Pressure');
xlabel('position');
ylabel('Dimensionless Pressure');


% g)
tend = 40;
nend = ceil(tend/dt);
dt = tend/nend;

vh = @(l,r)vhflux(l,r);
ch = @(l,r)chflux(l,r);
w = u;
for i = 1:nend
	for j = 2:size(u,1)-1
		l1 = u(j-1,:);
		l = u(j,:);
		r = u(j+1,:);
		w(j,:) = u(j,:)+dt/dx*(vh(l,r)-vh(l1,l)-(ch(l,r) - ch(l1,l)));
	end
	u = w;
end
figure;
plot(1:size(u,1), u(:,1));
title('Pressure');
xlabel('position');
ylabel('Dimensionless Pressure');
figure;
plot(1:size(u,1), u(:,2)./u(:,1));
title('Speed');
xlabel('position');
ylabel('Dimensionless Speed');
figure;
plot(1:size(u,1), arfun(u,1,size(u,1),pressure));
title('Pressure');
xlabel('position');
ylabel('Dimensionless Pressure');

% h)
sqrt(dx)*norm(u(:,1)-w(:,1))
sqrt(dx)*norm(init2(:,1)-init(:,1))










