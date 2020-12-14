function [vet_mat_conf] = mat_conf(G, E, m, n)
% Matriz de referencia G
% Matriz de aproximacao(estimada)
%   Tp
soma = 0;
% Calculo do TP
for i= 1: m
	for j= 1: n
		if( G(i, j) > 0 & E(i, j) > 0 )
			soma = soma + 1;
		end
	end
end
vet_mat_conf(1) = soma;
%   Fp 
soma = 0;
for i= 1: m
	for j= 1: n
		if( G(i, j) > 0 & E(i, j) == 0 )
			soma = soma + 1;
		end
	end
end
vet_mat_conf(2) = soma;
%   TN
soma = 0;
for i= 1: m
	for j= 1: n
		if( G(i, j) == 0 & E(i, j) == 0 )
			soma = soma + 1;
		end
	end
end
vet_mat_conf(3) = soma;
%   FN
soma = 0;
for i= 1: m
	for j= 1: n
		if( G(i, j) == 0 & E(i, j) > 0 )
			soma = soma + 1;
		end
	end
end
vet_mat_conf(4) = soma;
