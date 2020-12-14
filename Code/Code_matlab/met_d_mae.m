function [r] = met_d_pfe(IG, IF, m, n)
aux1 = norm(IG -IF);
aux2 = norm(IG);
r = (aux1 / aux2) * 100;

