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
del = randi([50,rmax]);
nu    = randi([2,10]);
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
escala=mean2(II)*3;figure(1),imshow(imresize(II,1),[0,escala]);
%imshow(img)
