function [r] = met_vet_d_mae(vet, m)
aux1 = sum(abs(vet));
r = aux1 / m;

