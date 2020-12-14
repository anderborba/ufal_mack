function [E] = mat_conf(E, m, n)
% Matriz de referencia E
% Binariza entrada E
%   Tp
for i= 1: m
	for j= 1: n
		if( E(i, j) ~= 0 )
			E(i, j) = 1; 
		end
	end
end
