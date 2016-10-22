clear vars; close all;
% The initial condition function.
initial = @(x) 4 + 2 * cos(2*pi*x);
nothing = @(nj, u) 0;

% 2b)
% We start defining the initial values to be used.
nj = 100; stability_bound = 1; tend = 0.1; v = 0;
r = 0; % Because v = 0
range = 1/nj/2:1/nj:1;

% Because we want to know cell averages, so we compute at the midpoint
% I'm assuming the granularity to be sufficiently small so this is similar to taking actual averages.
u0 = initial(range);

figure;
hold on;
legend_text = [];
for tend = 0.1:0.1:0.5
	plot(range, burgers_no_muscl(nj, u0, v, stability_bound, tend, nothing));
	legend_text = [legend_text ;['tend=' num2str(tend)]];
end
title('2b: Solutions at various end times');
xlabel('Position');
ylabel('Conserved Quantity');
legend(legend_text);

% 2c)
% Again we start defining the initial values to be used.
nj = 100; stability_bound = 0.8; tend = 0.1; v = 0.05;
r = 0; % Because v = 0
range = 1/nj/2:1/nj:1;

% Because we want to know cell averages, so we compute at the midpoint
% I'm assuming the granularity to be sufficiently small so this is similar to taking actual averages.
u0 = initial(range);

figure;
hold on;
legend_text = [];
for tend = 0.1:0.1:0.5
	plot(range, burgers_no_muscl(nj, u0, v, stability_bound, tend, nothing));
	legend_text = [legend_text ;['tend=' num2str(tend)]];
end
title('2c: Solutions at various end times');
xlabel('Position');
ylabel('Conserved Quantity');
legend(legend_text);

% 2e)
% I would use an approximation by checking err(nj) and err(nj/2) to find an order of the error

% 2f)
less_nj = 40000;
less_range = 1/less_nj/2:1/less_nj:1;
less_cells = burgers_no_muscl(less_nj, initial(less_range), 0.00, 1, 0.1, nothing);

more_nj = 80000;
more_range = 1/more_nj/2:1/more_nj:1;
more_cells = burgers_no_muscl(more_nj, initial(more_range), 0.00, 1, 0.1, nothing);

% Not entirely sure...
fprintf('Error 2f: %d\n', sqrt(1/less_nj*sum((less_cells(1:end) - (sumpart(more_cells, more_nj/less_nj))).^2)));

figure;
plot(less_range, less_cells);
hold on;
plot(more_range, more_cells);
title('Comparison of double cells');
xlabel('Position');
ylabel('Conserved Quantity');
legend(['nj=' num2str(less_nj)], ['nj=' num2str(more_nj)]);
