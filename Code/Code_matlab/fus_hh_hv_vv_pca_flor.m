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
E1 = zeros(m, n);
E2 = zeros(m, n);
E3 = zeros(m, n);
E1 = img_hh;
E2 = img_hv;
E3 = img_vv;
COVAR =[reshape(E1, n * n, 1),reshape(E2, n * n, 1),reshape(E3, n * n, 1)];
C = cov(COVAR);
[V, D] = eig(C);
[SV, SD] = svd(C);
if D(1,1) >= D(2,2) 
  pca = V(:,1)./sum(V(:,1));
elseif (D(2,2) >= D(3,3))
  pca = V(:,2)./sum(V(:,2));
else
  pca = V(:,3)./sum(V(:,3));
end
%
%p1 = V(:,1)./sum(V(:,1));
%p2 = V(:,2)./sum(V(:,2));
%p3 = V(:,3)./sum(V(:,3));
%
imf = pca(1) * E1 + pca(2) * E2 + pca(3) * E3;
%imf1 = p1(1) * E1 + p1(2) * E2 + p1(3) * E3;
%imf2 = p2(1) * E1 + p2(2) * E2 + p2(3) * E3;
%imf3 = p3(1) * E1 + p3(2) * E2 + p3(3) * E3;
