function [bw, bw_strip, bw_entire] = gera_step_5_10_negativo(N, xl, xu, yl, yu, eps)
bw = 10.0 * ones(N);
bw_strip  = 10.0 * ones(N);
bw_entire = 10.0 * ones(N);
% Build a rectangle bw [xl + eps, xu - eps] X [yl + eps, yu - eps]
for i= xl + eps: xu - eps
	for j =  yl + eps: yu - eps
		bw(i, j)= 5.0;
	end
end
% Build a rectangle bw_strip [xl + eps, xu - eps] X [yl + eps, yu - eps]
for i= xl + eps: xu - eps
	for j =  yl + eps: yu - eps
		bw_strip(i, j)= 5.0;
	end
end
for i= xl + eps: xu - eps
	for j =  yl + eps: yu - eps
		bw_entire(i, j)= 5.0;
	end
end
% Define strip
bw_strip = bw_strip - bw;
% Upper rectangle [xl - eps, xu + eps] X [yl + eps, yu - eps]
for i= xl - eps: xl + eps
	for j =  yl + eps: yu - eps
		xaux = (i - (xl - eps)) / (2.0 * eps);
		bw_strip(i, j) = 5.0 * (1.0 - fun_smooth_ramp(xaux)) + 5.0 ;
		bw_entire(i, j)= 5.0 * (1.0 - fun_smooth_ramp(xaux)) + 5.0 ;
	end
end
% Lower rectangle [xu - eps, xu + eps] X [yl + eps, yu - eps]
for i= xu - eps: xu + eps
	for j =  yl + eps: yu - eps
		xaux = (i - (xu - eps)) / (2.0 * eps);
		bw_strip(i, j) = 5.0 * fun_smooth_ramp(xaux) + 5.0;
		bw_entire(i, j)= 5.0 * fun_smooth_ramp(xaux) + 5.0;
	end
end
% Left rectangle [xl + eps, xu - eps] X [yl - eps, yl + eps]
for i= xl + eps: xu - eps
	for j =  yl - eps: yl + eps
		yaux = (j - (yl - eps)) / (2.0 * eps);
		bw_strip(i, j) = 5.0 * (1.0 - fun_smooth_ramp(yaux)) + 5.0;
		bw_entire(i, j)= 5.0 * (1.0 - fun_smooth_ramp(yaux)) + 5.0;
	end
end
% Right rectangle [xl + eps, xu - eps] X [yu - eps, yu + eps]
for i= xl + eps: xu - eps
	for j =  yu - eps: yu + eps
		yaux = (j - (yu - eps)) / (2.0 * eps);
		bw_strip(i, j) = 5.0 * fun_smooth_ramp(yaux) + 5.0;
		bw_entire(i, j)= 5.0 * fun_smooth_ramp(yaux) + 5.0;
	end
end
% Smooth ramp to corner
% [xl - eps, xl + eps] X [yl - eps, yl + eps]
for i= xl - eps: xl + eps
	for j= yl - eps: yl + eps
		xaux = (i - (xl - eps)) / (2.0 * eps);
		yaux = (j - (yl - eps)) / (2.0 * eps);
		bw_strip(i, j) = 5.0 * (1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
		bw_entire(i, j)= 5.0 * (1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
	end
end
% [xl - eps, xl + eps] X [yu - eps, yu + eps]
for i= xl - eps: xl + eps
	for j= yu - eps: yu + eps
		xaux = (i - (xl - eps)) / (2.0 * eps);
		yaux = 1.0 - (j - (yu - eps)) / (2.0 * eps);
		bw_strip(i, j) = 5.0 * (1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
		bw_entire(i, j)= 5.0 * (1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
	end
end
% [xu - eps, xu + eps] X [yl - eps, yl + eps]
for i= xu - eps: xu + eps
	for j= yl - eps: yl + eps
		xaux = 1.0 - (i - (xu - eps)) / (2.0 * eps);
		yaux =       (j - (yl - eps)) / (2.0 * eps);
		bw_strip(i, j)= 5.0 * (1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
		bw_entire(i, j)= 5.0 * ( 1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
	end
end
% [xu - eps, xu + eps] X [yu - eps, yu + eps]
for i= xu - eps: xu + eps
	for j= yu - eps: yu + eps
		xaux = 1.0 - (i - (xu - eps)) / (2.0 * eps);
		yaux = 1.0 - (j - (yu - eps)) / (2.0 * eps);
		bw_strip(i, j)= 5.0 * (1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
		bw_entire(i, j)= 5.0 * (1.0 - fun_smooth_ramp_3d_corner(xaux, yaux)) + 5.0;
	end
end
