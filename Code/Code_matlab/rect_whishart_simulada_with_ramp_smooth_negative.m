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
bw_entire = zeros(N);
eps = 50;
sy = 100;
sx = 200;
xl = (N/2 - sy);
xu = (N/2 + sy);
yl = (N/2 - sx);
yu = (N/2 + sx);
[bw, bw_strip, bw_entire] = gera_step_0_1_negativo(N, xl, xu, yl, yu, eps);
%[bw, bw_strip, bw_entire] = gera_step_5_10_negativo(N, xl, xu, yl, yu, eps);
%
img1 = zeros(N);
img2 = zeros(N);
img3 = zeros(N);
img1 = bw_strip;
% Becareful step = 0 to 1
img2 = 1.0 - bw;
% Becareful step = 5 to 10
%img2 = 10.0 - bw;
img3 = bw_entire - bw_strip;
[rows1, cols1] = find(img1);
[rows2, cols2] = find(img2);
[rows3, cols3] = find(img3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inserindo a distribuiçao Wishart %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Height = N;
Width  = N;
[phantom] = Generate_PolSAR_two_classes_phantom_rectangle_with_ramp_neg(S, L, Height, Width, img1, rows1, cols1, bw, rows2, cols2, img3, rows3, cols3);
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
	fname = sprintf('Phantom_rectangle_ramp_smooth_mu1_greater_mu2_negative_step_5_10_%d_%d.txt', canal, eps);
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
