function [f] = fun_smooth_ramp_3d_corner(x, y)
	f1 = 6.0 * x^5 - 15.0 * x^4 + 10.0 * x^3;
	f2 = 6.0 * y^5 - 15.0 * y^4 + 10.0 * y^3;
	f = f1 * f2;
