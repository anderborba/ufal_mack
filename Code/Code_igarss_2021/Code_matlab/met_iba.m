function [r] = met_iba(v, vm, alpha)
r1 = met_dominance(v);
r = (1 + alpha * r1) * vm;
