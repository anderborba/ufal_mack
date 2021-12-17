%  AAB - versao 1.0 - Data: 08/12/2021
%
%
% obs:
%     
%     
clc;           % limpa screen
clear;         % limpa workspace
close all;     % fecha todas as janelas abertas
format long;   % Dupla precisão
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load S_2_classes.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 800;    % Tamanho da imagem N X N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preenchimento de figura %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bw = zeros(N);
bw_strip = zeros(N);
eps = 5;
sx = 100;
sy = 200;
xl = (N/2 - sx);
xu = (N/2 + sx);
yl = (N/2 - sy);
yu = (N/2 + sy);
% Build a rectangle bw [xl + eps, xu - eps] X [yl + eps, yu - eps]
for i= xl + eps: xu - eps
	for j =  yl + eps: yu - eps
		bw(i, j)= 1.0;
	end
end
% Build a rectangle bw_strip [xl + eps, xu - eps] X [yl + eps, yu - eps]
for i= xl + eps: xu - eps
	for j =  yl + eps: yu - eps
		bw_strip(i, j)= 1.0;
	end
end
% Define strip
bw_strip = bw_strip - bw;
% Upper rectangle [xl - eps, xu + eps] X [yl + eps, yu - eps]
for i= xl - eps: xl + eps
	for j =  yl + eps: yu - eps
		xaux = (i - (xl - eps)) / (2.0 * eps);
		bw_strip(i, j)= fun_smooth_ramp(xaux);
	end
end
% Lower rectangle [xu - eps, xu + eps] X [yl + eps, yu - eps]
for i= xu - eps: xu + eps
	for j =  yl + eps: yu - eps
		xaux = (i - (xu - eps)) / (2.0 * eps);
		bw_strip(i, j)= 1.0 - fun_smooth_ramp(xaux);
	end
end
% Left rectangle [xl + eps, xu - eps] X [yl - eps, yl + eps]
for i= xl + eps: xu - eps
	for j =  yl - eps: yl + eps
		yaux = (j - (yl - eps)) / (2.0 * eps);
		bw_strip(i, j)= fun_smooth_ramp(yaux);
	end
end
% Right rectangle [xl + eps, xu - eps] X [yu - eps, yu + eps]
for i= xl + eps: xu - eps
	for j =  yu - eps: yu + eps
		yaux = (j - (yu - eps)) / (2.0 * eps);
		bw_strip(i, j)= 1.0 - fun_smooth_ramp(yaux);
	end
end
% Smooth ramp to corner
% [xl - eps, xl + eps] X [yl - eps, yl + eps]
for i= xl - eps: xl + eps
	for j= yl - eps: yl + eps
		xaux = (i - (xl - eps)) / (2.0 * eps);
		yaux = (j - (yl - eps)) / (2.0 * eps);
		bw_strip(i, j)= fun_smooth_ramp_3d_corner(xaux, yaux);
	end
end
% [xl - eps, xl + eps] X [yu - eps, yu + eps]
for i= xl - eps: xl + eps
	for j= yu - eps: yu + eps
		xaux = (i - (xl - eps)) / (2.0 * eps);
		yaux = 1.0 - (j - (yu - eps)) / (2.0 * eps);
		bw_strip(i, j)= fun_smooth_ramp_3d_corner(xaux, yaux);
	end
end
% [xu - eps, xu + eps] X [yl - eps, yl + eps]
for i= xu - eps: xu + eps
	for j= yl - eps: yl + eps
		xaux = 1.0 - (i - (xu - eps)) / (2.0 * eps);
		yaux =       (j - (yl - eps)) / (2.0 * eps);
		bw_strip(i, j)= fun_smooth_ramp_3d_corner(xaux, yaux);
	end
end
% [xu - eps, xu + eps] X [yu - eps, yu + eps]
for i= xu - eps: xu + eps
	for j= yu - eps: yu + eps
		xaux = 1.0 - (i - (xu - eps)) / (2.0 * eps);
		yaux = 1.0 - (j - (yu - eps)) / (2.0 * eps);
		bw_strip(i, j)= fun_smooth_ramp_3d_corner(xaux, yaux);
	end
end
%
im = zeros(N);
img1 = zeros(N);
img2 = zeros(N);
img1 = im + bw_strip;
img2 = im + bw;
[rows1, cols1] = find(img1);
[rows2, cols2] = find(img2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inserindo a distribuiçao Wishart %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Height = N;
Width  = N;
[phantom] = Generate_PolSAR_two_classes_phantom_rectangle_with_ramp(S, L, Height, Width, img1, rows1, cols1, img2, rows2, cols2);
%Activate to visualize the Monte Carlo phantom generated
% Visualize Pauli's representation of phantom generated
Ihh=mat2gray(real(phantom(:,:,1)));
Ihh=imadjust(Ihh);
Ihv=mat2gray(real(phantom(:,:,2)));
Ihv=imadjust(Ihv);
Ivv=mat2gray(real(phantom(:,:,3)));
Ivv=imadjust(Ivv);
%
II=cat(3,abs(Ihh + Ivv), abs(Ihv), abs(Ihh - Ivv));
II = imresize(II,1);
escala=mean2(II)*3;figure(1),imshow(II,[0,escala]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Escreve em arquivo *.txt as informações das retas radiais nas imagens
% flores phantons nos canais (hh, hv, vv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
cd ..
cd Data
for canal = 1: 3
	fname = sprintf('Phantom_rectangle_ramp_smooth_mu1_less_mu2_%d.txt', canal);
	fid = fopen(fname,'w');
	for i = 1: N
		for j = 1: N
	        	fprintf(fid,'%f ', phantom(i, j, canal));
       	end
    		fprintf(fid,'\n');
        end
        fclose(fid);       
end
cd ..
cd Code/Code_matlab
