u = -0.25;
nj = 100;
t0 = zeros(nj, 1);
tb = 1000;
t0(nj/2:end) = tb;
c = -0.5;
tend = 0.04;

% 2e) 2f)
figure;
plot(1/nj/2:1/nj:1, upwind(-0.25, tb, nj, t0, c, tend));
hold on;

tperfect = zeros(nj, 1);
boundary = 0.5 + u*tend;
tperfect(boundary*nj:end) = tb;
plot(1/nj/2:1/nj:1, tperfect, 'o');
legend('upwind', 'perfect');

title('Solving advective heat upwind vs perfect, c=-0.5, tend=0.04');
xlabel('Position');
ylabel('Temperature');

% 2g)
figure;
tperfect = zeros(nj, 1);
boundary = 0.5 + u*1.2;
tperfect(boundary*nj:end) = tb;
plot(1/nj/2:1/nj:1, tperfect, 'o');
hold on;

for c = -1:1/4:0
	plot(1/nj/2:1/nj:1, upwind(-0.25, tb, nj, t0, c, 1.2));
end
legend('perfect', 'c=-1', 'c=-0.75', 'c=-0.5', 'c=-0.25', 'c=0');

title('Various solutions for different c, tend=1.2');
xlabel('Position');
ylabel('Temperature');

% 2h)
figure;
t0 = sin(2*pi*(1:nj)/100);
hold on;
perfect = upwind(-0.25, tb, nj, t0, -1, 1.2);
for c = -1:1/4:0
	approx = upwind(-0.25, tb, nj, t0, c, 1.2);
	plot(1/nj/2:1/nj:1, approx);
	fprintf('2-norm with c=%d: %d\n', c, norm(approx - perfect)*(1/nj)^(1/2));
end
legend('c=-1 (perfect)', 'c=-0.75', 'c=-0.5', 'c=-0.25', 'c=0 (initial)');

title('Various solutions for different c, tend=1.2');
xlabel('Position');
ylabel('Temperature');
