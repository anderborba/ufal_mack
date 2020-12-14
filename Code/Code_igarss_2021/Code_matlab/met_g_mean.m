function [r] = met_spec(v)
r1 = v(1) / (v(1) + v(4));
r2 = v(3) / (v(3) + v(2));
r = sqrt(r1 * r2);
