function computed = texact(points, time, left_temp, right_temp, length, diffusivity, m)
	count = 0;
	computed(numel(points)) = 0;
	if time == 0
		return;
	end
	for point = points
		count = count + 1;
		ts = left_temp + (right_temp - left_temp) / length * point;
		partial_sum = 0;
		for i = 1:m
			partial_sum = partial_sum + 2/pi/i * (right_temp * (-1)^i - left_temp) * ...
				sin(i*pi*point/length) * exp(-diffusivity*i^2*pi^2/length^2*time);
		end
		computed(count) = ts + partial_sum;
	end
end
