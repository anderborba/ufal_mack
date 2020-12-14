function [r] = met_bm(v)
r = met_recall(v) + met_spec(v) - 1;
