function result = rusanov(u, nj, dt, tend)

	dx = 2/nj;
	nend = ceil(tend/dt);
	dt = tend/nend;

	cells_new = u;

	hf = @halfflux;

	for i=1:nend

		cells_new(1,:) = u(1,:) - dt/dx .* ...
			(hf(u(1,:), u(2,:)) - flux(u(1,:)));
		for j=2:nj-1
			cells_new(j,:) = u(j,:) - dt/dx .* ...
				(hf(u(j,:), u(j+1,:)) - hf(u(j-1,:), u(j,:)));
		end
		cells_new(nj,:) = u(nj,:) - dt/dx .* ...
			(flux(u(nj,:) - hf(u(nj-1,:), u(nj,:))));

		u = cells_new;
	end

	result = u;

end

