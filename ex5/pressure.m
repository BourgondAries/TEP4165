function result = pressure(u)
	result = 0.4*(u(3) - 1/2*(u(2)^2)/u(1));
end
