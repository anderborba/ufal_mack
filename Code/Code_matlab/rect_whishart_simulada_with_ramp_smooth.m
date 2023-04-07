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
%bw = zeros(N) + 5.0;
%bw_strip = zeros(N)+ 5.0;
bw = zeros(N);
bw_strip = zeros(N);
eps = 10;
sx = 100;
sy = 200;
xl = (N/2 - sx);
xu = (N/2 + sx);
yl = (N/2 - sy);
yu = (N/2 + sy);
%[bw, bw_strip] = gera_step_0_1(N, xl, xu, yl, yu, eps);
[bw, bw_strip] = gera_step_5_10(N, xl, xu, yl, yu, eps);
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
	fname = sprintf('Phantom_rectangle_ramp_smooth_mu1_less_mu2_step_5_10_%d_%d.txt', canal, eps);
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
