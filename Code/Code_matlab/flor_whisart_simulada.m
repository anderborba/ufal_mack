%  AAB - versao 1.0 - Data: 19/11/2018
%
%
% obs (1) nu    - altura da petala
%     (2) beta  - é o numero de petalas
%     (3) del - é a altura de onda em cada petala
clc;           % limpa screen
clear;         % limpa workspace
close all;     % fecha todas as janelas abertas
format long;   % Dupla precisão
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load S_2_classes.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 800;    % Tamanho da imagem N X N
rmax = 200; % Raio maximo da flor
beta  = randi([5,30]);
del   = randi([50,rmax]);
nu    = randi([2,10]);
beta  = 8;
del   = 103;
nu    = 3;
x0 = N / 2;
y0 = N / 2;
t = linspace(0, 2 * pi, 2 * del) - pi;
r =  (del - nu * cos(beta * t));
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preenchimento de figura %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bw = zeros(N);
bw = poly2mask(x,y, N, N);
im = zeros(N);
img = zeros(N);
img = im + bw;
[rows, cols] = find(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inserindo a distribuiçao Wishart %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Height = N;
Width  = N;
%phantom = zeros(Height, Width, 9);
[phantom] = Generate_PolSAR_two_classes_phantom_flor(S, L, Height, Width, img, rows, cols);
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
%escala=mean2(II)*3;figure(1),imshow(II,[0,escala]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% incluindo pontos radiais imagem binaria 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_radial = 400;
tr = linspace(0, 2 * pi, num_radial + 1);
r =  2 * del;
x = x0 + r .* cos(tr);
y = y0 + r .* sin(tr);
xr= round(x);
yr= round(y);
for i = 1: num_radial
%	img(xr(i), yr(i)) = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% incluindo retas radiais imagem binaria
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1: num_radial
	[myline, mycoords, outmat, XT1, YT1] = bresenham(img, [x0, y0; xr(i), yr(i)], 0);
	for j = 1: length(XT1)
	       %img(X(j), Y(j)) = myline(j);
	      % img(XT1(j), YT1(j)) = 0;
        end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% incluindo pontos radiais imagem flor 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1: num_radial
%	II(xr(i), yr(i)) = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% incluindo retas radiais imagem flor II, Ihh, Ihv e Ivv 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%const =  5 * max(max(max(II)));
%for i = 1: num_radial
%	[myline, mycoords, outmat, XT2, YT2] = bresenham(II, [x0, y0; xr(i), yr(i)], 0);
%	dim = length(XT2);
%	for j = 1: dim
%	       II (XT2(j), YT2(j)) = const;
%	       Ihh(XT2(j), YT2(j)) = const;
%	       Ihv(XT2(j), YT2(j)) = const;
%	       Ivv(XT2(j), YT2(j)) = const;
%        end
%end
escala=mean2(II)*3;figure(1),imshow(II,[0,escala]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extrai retas radiais e as distribuicoes nas imagens flores phantons nos canais (hh, hv, vv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% obs: cada canal produz seus proprios X, Y com dimensões diferentes!!!!
%% Mat com numero de colunas 400, para armazenar os X e Y com dim  variaveis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MY = zeros(num_radial, N / 2, 3);
for canal = 1 : 3
	for i = 1: num_radial
		Iaux = phantom(:, :, 1);
		[myline, mycoords, outmat, XC, YC] = bresenham(Iaux, [x0, y0; xr(i), yr(i)], 0);
		dimc = length(XC);
		for j = 1: dimc
			MY(i, j, canal) = myline(j);
        	end
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Escreve em arquivo *.txt as informações das retas radiais nas imagens
% flores phantons nos canais (hh, hv, vv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cd ..
%cd ..
%cd Data
%for canal = 1: 3
%	fname = sprintf('radial_flor_%d_%d_%d_%d.txt', beta, del, nu, canal);
%	fid = fopen(fname,'w');
%	for i = 1: num_radial
%		for j = 1: N / 2
%	                fprintf(fid,'%f ',MY(i, j, canal));
%       	end
%    		fprintf(fid,'\n');
%        end
%        fclose(fid);       
%end
%cd ..
%cd Code/Code_matlab
