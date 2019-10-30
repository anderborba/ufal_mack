function [F] = fus_roc(E, m, n, nc)
V(1: m, 1: n)  = 0.0;
M(1: m, 1: n, 1: nc) = 0.0;
for i = 1: nc
	V(:, :) = V(:, :) + E(:, :, i);
end
for i= 1: m
	for j= 1: n
		if( V(i,j) >= 1 & V(i, j) <= nc)
			M(i, j, 1) = 1;
		end
		if( V(i,j) >= 2 & V(i, j) <= nc)
	        	M(i, j, 2) = 1;
		end
		if( V(i,j) >= 3 & V(i, j) <= nc)
			M(i, j, 3) = 1;
		end
	%	if( V(i,j) >= 4 & V(i, j) <= nc)
	%		M(i, j, 4) = 1;
	%	end
	%	if( V(i,j) >= 5 & V(i, j) <= nc)
	%		M(i, j, 5) = 1;
	%	end
	%	if( V(i, j) == nc )
	%		M(i, j, 6) = 1;
	%	end
	end
end
F = M(:,:, 3);
