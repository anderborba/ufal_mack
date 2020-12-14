function [r] = met_d_rms(mat_erro, m, n)
aux1 = 1 / (m * n);
aux2 = sum(sum(mat_erro));
r = sqrt(aux1 * aux2^2);

