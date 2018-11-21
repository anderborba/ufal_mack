%  AAB - versao 1.0 - Data: 19/11/2018
%  Programa de estudo para gerar uma imagem de flor simulada em coordenadas polares.
% obs (1) raio_circ = altura petal  - diametro de cada petala
%     (2) k  - é o numero de petalas
%     (3) b - é altura de cada onda. obs na página
%    http://jwilson.coe.uga.edu/EMAT6680Fa07/Hallman/Assignment%2011/assignm%2011.html 
%The b value will determine the height of each wave. The minimum of each wave is 4 units from the origin and the maximum of each wave is the 6 units from the origin and the average of 4 and 6 is in fact 5, our b value. (We’re going to find a more sophisticated way to talk about this shortly, hand in there.) Does that always work? Let’s Try for a different value of b. when b = 5.
clc;           % limpa screen
clear;         % limpa workspace
close all;     % fecha todas as janelas abertas
format long;   % Dupla precisão
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = linspace(0, 2 * pi, 1000) - pi;
raio_circ = 1;   % diametro da circunferencia
r1 =  raio_circ* cos(t);
x1 = r1 .* cos(t);
y1 = r1 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
raio_circ = 2;   % diametro da circunferencia
r2 = raio_circ * cos(t);
x2 = r2 .* cos(t);
y2 = r2 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
raio_circ = 4;   % diametro da circunferencia
r3 = raio_circ * cos(t);
x3 = r3 .* cos(t);
y3 = r3 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
raio_circ = 8;   % diametro da circunferencia
r4 = raio_circ * cos(t);
x4 = r4 .* cos(t);
y4 = r4 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(x1, y1, 'm-',x2, y2, 'r-',x3, y3, 'b-',x4, y4, 'c-')
%axis equal;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% introdução do parametro k
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 2;          % numero de pelalas 2 * k (k par)
alt_petal = 8;  % altura da petala
r5 = alt_petal * cos(k * t);
x5 = r5 .* cos(t);
y5 = r5 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 4;          % numero de pelalas 2 * k (k par)
alt_petal = 8; % altura da petala
r6 = alt_petal * cos(k * t);
x6 = r6 .* cos(t);
y6 = r6 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 6;          % numero de pelalas 2 * k (k par)
alt_petal = 8; % altura da petala
r7 = alt_petal * cos(k * t);
x7 = r7 .* cos(t);
y7 = r7 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 8;          % numero de pelalas 2 * k (k par)
alt_petal = 8; % altura da petala
r8 = alt_petal * cos(k * t);
x8 = r8 .* cos(t);
y8 = r8 .* sin(t);
%plot(x5, y5, 'r-',x6, y6, 'b-', x7, y7, 'g-', x8, y8, 'm-')
%axis equal;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 3;          % numero de pelalas k  (k impar)
alt_petal = 8; % altura da petala
r9 = alt_petal * cos(k * t);
x9 = r9 .* cos(t);
y9 = r9 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 5;          % numero de pelalas k  (k impar)
alt_petal = 8; % altura da petala
r10 = alt_petal * cos(k * t);
x10 = r10 .* cos(t);
y10 = r10 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 7;          % numero de pelalas k  (k impar)
alt_petal = 8; % altura da petala
r11 = alt_petal * cos(k * t);
x11 = r11 .* cos(t);
y11 = r11 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 9;          % numero de pelalas k  (k impar)
alt_petal = 8; % altura da petala
r12 = alt_petal * cos(k * t);
x12 = r12 .* cos(t);
y12 = r12 .* sin(t);
%plot(x9, y9, 'r-',x10, y10, 'b-',x11, y11, 'g-',x12, y12, 'm-')
%axis equal;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% introdução do parametro b 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 3;          % numero de pelalas k  (k impar)
alt_petal = 1;  % altura da petala
b = 5;          % raio da flor
r13 = b - alt_petal * cos(k * t);
x13 = r13 .* cos(t);
y13 = r13 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 4;          % numero de pelalas k  (k impar)
alt_petal = 1;  % altura da petala
b = 5;          % raio da flor
r14 = b - alt_petal * cos(k * t);
x14 = r14 .* cos(t);
y14 = r14 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 5;          % numero de pelalas k  (k impar)
alt_petal = 1;  % altura da petala
b = 5;          % raio da flor
r15 = b - alt_petal * cos(k * t);
x15 = r15 .* cos(t);
y15 = r15 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 6;          % numero de pelalas k  (k impar)
alt_petal = 1;  % altura da petala
b = 5;          % raio da flor
r16 = b - alt_petal * cos(k * t);
x16 = r16 .* cos(t);
y16 = r16 .* sin(t);
%plot(x13, y13, 'r-', x14, y14, 'b-',x15, y15, 'g-',x16, y16, 'm-')
%axis equal;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Aumentando a altura petal com b e k fixos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 6;          % numero de pelalas k  (k impar)
alt_petal = 1;  % altura da petala
b = 5;          % raio da flor
r17 = b - alt_petal * cos(k * t);
x17 = r17 .* cos(t);
y17 = r17 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 6;          % numero de pelalas k  (k impar)
alt_petal = 2;  % altura da petala
b = 5;          % raio da flor
r18 = b - alt_petal * cos(k * t);
x18 = r18 .* cos(t);
y18 = r18 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 6;          % numero de pelalas k  (k impar)
alt_petal = 3;  % altura da petala
b = 5;          % raio da flor
r19 = b - alt_petal * cos(k * t);
x19 = r19 .* cos(t);
y19 = r19 .* sin(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 6;          % numero de pelalas k  (k impar)
alt_petal = 4;  % altura da petala
b = 5;          % raio da flor
r20 = b - alt_petal * cos(k * t);
x20 = r20 .* cos(t);
y20 = r20 .* sin(t);
plot(x17, y17, 'r-', x18, y18, 'b-',x19, y19, 'g-', x20, y20, 'm-')
axis equal;
