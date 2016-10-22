function result = sumpart(vector, consecutives)
	result = [];
	for i = 1:consecutives:numel(vector)
		result = [result, sum(vector(i:i+consecutives-1))];
	end
	result = result * 1/consecutives;
end
