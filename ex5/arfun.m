function result = arfun(matrix, from, to, functor)
	for i=from:to
		result(i) = functor(matrix(i,:));
	end
end
