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
%load S_2_classes.mat
cd ..
cd ..
cd Data/
evidencias_hh = load('evidencias_flor_25_155_5_1.txt');
evidencias_hv = load('evidencias_flor_25_155_5_2.txt');
evidencias_vv = load('evidencias_flor_25_155_5_3.txt');
cd ..
cd Code/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 800;    % Tamanho da imagem N X N
rmax = 200; % Raio maximo da flor
%beta  = randi([5,30]);
%del = randi([50,rmax]);
%nu    = randi([2,10]);
beta  = 25;
del   = 155;
nu    = 5;
x0 = N / 2;
y0 = N / 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img       = zeros(N);
img_aprox = zeros(N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% incluindo flor na imagem 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_radial = 400;
t = linspace(0, 2 * pi, num_radial + 1);
r =  (del - nu * cos(beta * t));
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xd= round(x);
yd= round(y);
for i = 1: 2 * del
	%img(xr(i), yr(i)) = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% incluindo pontos radiais imagem binaria 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr = linspace(0, 2 * pi, num_radial + 1);
r =  2 * del;
x = x0 + r .* cos(tr);
y = y0 + r .* sin(tr);
xr= round(x);
yr= round(y);
for i = 1: num_radial
	%img(xr(i), yr(i)) = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Fusão de evidências
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
evidencias = zeros(num_radial, 1);
for i = 1: num_radial
evidencias(i) = (evidencias_hh(i, 3) + evidencias_hv(i, 3) + evidencias_vv(i, 3)) / 3;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Interpolação 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = evidencias;
%x = evidencias_hh(:, 1);
%p_coef = polyfit(x, y, 3);
%p = polyval(p_coef, x);
%yy = splines(x, y, x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% incluindo as evidencias de bordas na imagem binaria
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
evidencias = round(evidencias);
MXT = zeros(num_radial, N / 2);
MYT = zeros(num_radial, N / 2);
for i = 1: num_radial
	[myline, mycoords, outmat, XT1, YT1] = bresenham(img, [x0, y0; xr(i), yr(i)], 0);
	for j = 1: length(XT1)
	       MXT(i, j) = XT1(j);
	       MYT(i, j) = YT1(j);
	       %img(XT1(j), YT1(j)) = 1;
        end
	img_aprox(XT1(evidencias(i)), YT1(evidencias(i))) = 1;
        img      (xd(i), yd(i)) = 1;
end
img_erro = abs(img_aprox - img);
norma1 = norm(img_erro, 1);
norma2 = norm(img_erro, 2);
%img       = 1 - img;
%img_aprox = 1 - img_aprox;
