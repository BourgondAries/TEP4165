function result = vhflux(l, r)
	f = @vflux;
	result = 1/2*(f(l) + f(r));
end
