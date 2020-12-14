function [r] = met_d_srn(IG, IF, m, n)
aux1 = IG^2;
aux2 =sum(sum(aux1));
erro = (IG - IF)^2;
aux3 = sum(sum(erro));
aux4 = aux2 / aux3;
r = 20 * log10(aux4);

