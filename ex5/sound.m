function result = sound(u)
	p = pressure(u);
	result = sqrt(1.4*p/u(1));
end
