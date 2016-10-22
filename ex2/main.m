% 2c)
length = 1;
nj = 100;
plot(1/nj/2:1/nj:1, solve2(nj, zeros(nj, 1), 0.4, 0.08, 1e-3, -100, 500));
title('After 0.4 s');
xlabel('Position');
ylabel('Temp');

% 2d)
plot_count = 5;
plot_number = 1;

figure;
subplot(plot_count,1,plot_number);
plot_number = plot_number + 1;
nj = 100;
temps_stable = solve2(nj, zeros(nj, 1), 0.4, 50.0, 1e-3, -100, 500);

% Plotting using r=0.4
plot(length/nj/2:length/nj:length, temps_stable);
title('Using r=0.4');
xlabel('Point');
ylabel('Temp');

% Plotting using r=0.501 to observe instability
subplot(plot_count,1,plot_number);
plot_number = plot_number + 1;
temps = solve2(nj, zeros(nj, 1), 0.501, 50.0, 1e-3, -100, 500);
plot(length/nj/2:length/nj:length, temps);
title('Using r=0.501');
xlabel('Point');
ylabel('Temp');

% 2f) Iterates over each nj choice and creates a new plot
for nj = [100 200 400]
	time_end = 1000.0;
	temps_stable = solve2(nj, zeros(nj, 1), 0.4, time_end, 1e-3, -100, 500);
	temps_exact = texact(length/nj/2:length/nj:length, time_end, -100.0, 500.0, 1, 1e-3, 50);

	temps_diff = temps_exact - transpose(temps_stable);
	subplot(plot_count,1,plot_number);
	plot_number = plot_number + 1;
	plot(length/nj/2:length/nj:length, temps_diff);
	hold on;
	plot(length/nj/2:length/nj:length, abs(temps_diff));
	title(['Difference from exact with nj=' num2str(nj)]);
	xlabel('Point');
	ylabel('Temp Diff');
	legend('diff', 'abs diff');

	% 2g) Computing the 2-norm
	fprintf('(Error-norm :nj %d :norm %s)\n', nj, sqrt(1/nj) * norm(temps_diff));
end
