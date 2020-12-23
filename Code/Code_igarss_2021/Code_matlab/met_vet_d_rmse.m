function [r] = met_vet_d_rmse(vet, m)
aux1 = sum(vet.^2);
r = sqrt(aux1 / m);

