function [r] = met_diminance(v)
r1 = met_recall(v);
r2 = met_spec(v);
r = r1 - r2;
