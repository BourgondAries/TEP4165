x = 0:0.01:1;
diffusivity = 10^-3;
t1 = -100;
t2 = 500;
l = 1;
t = 0:5:25;
m = input('Set the m value: ');

for time = t
	display(sprintf('With t=%0.5f:', time));
	display(texact(x, time, t1, t2, l, diffusivity, m));
end
