function r = chflux(l, r)
	f = @cflux;
	r = 1/2*(f(l) + f(r));
end
