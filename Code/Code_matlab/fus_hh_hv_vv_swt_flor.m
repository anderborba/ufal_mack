% Programado por AAB - versao 1.0 **/**/20**
% O programa le arquivos com evidencias de bordas para diferentes canais no diretortio ~/Data e faz a fusão das evidencias para os diferentes canais, com o método estatístico usando a curva ROC. Diretorio de impressão /Text/Dissertacao/figurasi
% Obs (1) Na linguagem r o arquivo gravado leva o nome da base de dados na primeira linha dos arquivos, verificar se já foi retirado a linha com os nomes das bases de dados, senão vai dar erro na leitura.
%     (2) Mudar os nomes dos arquivos de entrada e saida mudando as amostras.
%     (3) Escrita em arquivo comentada para evitar mudanças nas figuras.
clear all;
format long;
% leitura do arquivos de evidencias de bordas no diretorio ~/Data
% dados baseados nas referencias \cite{nhfc} e \cite{gamf}
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_nhfc.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_nhfc.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_nhfc.txt');
ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_1.txt');
ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_2.txt');
ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_3.txt');
%
ev_1 = ev_hh(:, 3);
ev_2 = ev_hv(:, 3);
ev_3 = ev_vv(:, 3);
%
% processando evidencias para gerar imagens de flor
N = 800;    % Tamanho da imagem N X N
m = N;
n = N;
nc = 3; % número de canais considerado
rmax = 200; % Raio maximo da flor
beta  = 25;
del   = 155;
nu    = 5;
x0 = N / 2;
y0 = N / 2;
img_hh = zeros(N); 
img_hv = zeros(N); 
img_vv = zeros(N); 
evidencias_hh = round(ev_hh);
evidencias_hv = round(ev_hv);
evidencias_vv = round(ev_vv);
num_radial = 400;
tr = linspace(0, 2 * pi, num_radial + 1);
r =  2 * del;
x = x0 + r .* cos(tr);
y = y0 + r .* sin(tr);
xr= round(x);
yr= round(y);
for i = 1: num_radial
	[myline, mycoords, outmat, XT1_hh, YT1_hh] = bresenham(img_hh, [x0, y0; xr(i), yr(i)], 0);
	[myline, mycoords, outmat, XT1_hv, YT1_hv] = bresenham(img_hv, [x0, y0; xr(i), yr(i)], 0);
	[myline, mycoords, outmat, XT1_vv, YT1_vv] = bresenham(img_vv, [x0, y0; xr(i), yr(i)], 0);
	img_hh(XT1_hh(evidencias_hh(i, 3)), YT1_hh(evidencias_hh(i, 3))) = 1;
	img_hv(XT1_hv(evidencias_hv(i, 3)), YT1_hv(evidencias_hv(i, 3))) = 1;
	img_vv(XT1_vv(evidencias_vv(i, 3)), YT1_vv(evidencias_vv(i, 3))) = 1;
end
%img_hh = 1 - img_hh;
%img_hv = 1 - img_hv;
%img_vv = 1 - img_vv;
%
im1 = img_hh;
im2 = img_hv;
im3 = img_vv;
%figure(1);
%subplot(121);imshow(im1,[]);
%subplot(122);imshow(im2,[]);
%figure(2);
%imshow(im3,[]);
% image decomposition using discrete stationary wavelet transform
[A1,H1,V1,D1] = swt2(im1,1,'sym2');
[A2,H2,V2,D2] = swt2(im2,1,'sym2');
[A3,H3,V3,D3] = swt2(im3,1,'sym2');

% fusion start ideia 1
%AfL1 = 0.5*(A1L1+A2L1);
%D = (abs(H1L1)-abs(H2L1))>=0;
%HfL1 = D.*H1L1 + (~D).*H2L1;
%D = (abs(V1L1)-abs(V2L1))>=0;
%VfL1 = D.*V1L1 + (~D).*V2L1;
%D = (abs(D1L1)-abs(D2L1))>=0;
%DfL1 = D.*D1L1 + (~D).*D2L1;
% fusion start ideia 1
Af   = (A1 + A2 + A3) / 3.0;
AUX1 = max(H1  , H2);
Hf   = max(AUX1, H3);
AUX2 = max(V1  , V2);
Vf   = max(AUX2, V3);
AUX3 = max(D1  , D2);
Df   = max(AUX3, D3);

% fused image
imf = iswt2(Af,Hf,Vf,Df,'sym2');
figure(3); imshow(imf);
