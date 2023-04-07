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
evidencias = load('evidencias_flor_8_103_3_3.txt');
cd ..
cd Code/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 800;    % Tamanho da imagem N X N
rmax = 200; % Raio maximo da flor
%beta  = randi([5,30]);
%del = randi([50,rmax]);
%nu    = randi([2,10]);
beta  = 8;
del   = 103;
nu    = 3;
x0 = N / 2;
y0 = N / 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = zeros(N);
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
	%img(xr(i), yr(i)) = 1;
end
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
	img(XT1(evidencias(i, 3)), YT1(evidencias(i, 3))) = 1;
	xaux(i) = XT1(evidencias(i, 3));
	yaux(i) = YT1(evidencias(i, 3));
end
img = 1 - img;
