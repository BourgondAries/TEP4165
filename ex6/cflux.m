function result = cflux(u)
	p = pressure(u);
	result = [u(2) u(2)^2/u(1)+p u(2)/u(1)*(u(3)+p)];
end
