function [F] = fus_pca(E, m, n, nc)
for i = 1: nc
	COVAR(:, i) = reshape(E(:, :, i), m * n, 1);
end
C = cov(COVAR);
whos C
[V, D] = eig(C);
p = V(:, nc)./ sum(V(:, nc));
p
F = zeros(m, n);
aux = zeros(m, n);
for i = 1: nc
	aux(:, :) = E(:, :, i);
	F = F + p(i) * aux;
end
