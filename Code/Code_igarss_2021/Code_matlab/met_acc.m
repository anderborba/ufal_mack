function [r] = met_acc(v)
r = (v(1) + v(3)) / (v(1) + v(2) + v(3) + v(4));
