clc; clear all; close all;

% Create the cells
cell_count = 800;
cells = zeros(cell_count, 3);

% Initialize the cells with the initial conditions
cells(1:floor(cell_count/2), 1:3) = repmat([1 0 2500], floor(cell_count/2), 1);
cells(floor(cell_count/2)+1:end, 1:3) = repmat([1 0 0.025], floor(cell_count/2), 1);

for dtd=1:1:10
	input('Press enter to continue');
	close all;
	dt = 0.0187*2/cell_count;
	dt = dt/dtd;
	tend = 0.024;
	result = rusanov(cells, cell_count, dt, tend);

	tend_str = ['tend=' num2str(tend) ' dt=' num2str(dt)];

	figure; plot(linspace(-1,1,cell_count), result(:, 1));
	title(['density distribution ' tend_str]);
	xlabel('x');
	ylabel('rho');

	figure; plot(linspace(-1,1,cell_count), result(:, 2)./result(:, 1));
	title(['u distribution ' tend_str]);
	xlabel('x');
	ylabel('speed');

	figure; plot(linspace(-1,1,cell_count), arfun(result, 1, cell_count, @pressure));
	title(['p distribution ' tend_str]);
	xlabel('x');
	ylabel('pressure');
end
