function [F] = fus_media(E, m, n, nc)
soma(1:m, 1:n) = 0.0;
for i = 1: nc
	soma(:, :) = soma(:, :) + E(:, :, i); 
end
F = soma / nc;
