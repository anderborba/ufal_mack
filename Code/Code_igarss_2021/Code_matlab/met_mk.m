function [r] = met_mk(v)
r = met_spec(v) + met_npv(v) - 1;
