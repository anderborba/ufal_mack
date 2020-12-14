function [r] = met_med_f(v)
%
%    med_f = (2 * TP)/(2 * TP + FP +FN)
%
r = (2 * v(1)) / (2 * v(1) + v(2) + v(4));
