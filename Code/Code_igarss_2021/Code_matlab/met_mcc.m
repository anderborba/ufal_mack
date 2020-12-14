function [r] = met_mcc(v)
% Mcc normalizada
r = (v(1) * v(3) - v(2) * v(4)) / sqrt((v(1) + v(2)) * (v(1) + v(4)) * (v(3) + v(2)) * (v(3) + v(4)));
r = 0.5 *(r + 1);
