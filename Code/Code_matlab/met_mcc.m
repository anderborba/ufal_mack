function [r] = met_mcc(v)
r = (v(1) * v(3) - v(2) * v(4)) / sqrt((v(1) + v(2)) * (v(1) + v(4)) * (v(3) + v(2)) * (v(3) + v(4)));
