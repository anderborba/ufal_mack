% Coded by Anderson Borba data: 01/07/2020 version 1.0
% Fusion of Evidences in Intensities Channels for Edge Detection in PolSAR Images
% GRSL - IEEE Geoscience and Remote Sensing Letters
% Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
%
% Description
% 1) Read *.txt with edge evidence
% 2) Does the fusion method to San Francisco Bay (one at a times)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
% 2) Show the image (evidences ou fusion)
% Obs:  1) contact email: anderborba@gmail.com
%
clear all;
format long;
cd ..
cd Data
load SanFrancisco_Bay.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IT = zeros(nrows, ncols);
IF = zeros(nrows, ncols);

x0 = nrows / 2 + 120;
y0 = ncols / 2 - 260;
r = 120;
num_radial = 25;
t = linspace(0, 2 * pi, num_radial) ;
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ev_hh = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/evid_real_sf_hh_L_fixo_mu_media_25_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/evid_real_sf_hv_L_fixo_mu_media_25_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/evid_real_sf_vv_L_fixo_mu_media_25_pixel.txt');
ev_hh_hv_razao = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/evid_real_sf_hh_hv_razao_rho_tau_25_pixel.txt');
ev_hh_vv_razao = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/evid_real_sf_hh_vv_razao_rho_tau_25_pixel.txt');
ev_hv_vv_razao = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/evid_real_sf_hv_vv_razao_rho_tau_25_pixel.txt');
ev_span  = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/evid_real_sf_span_mu_media_25_pixel.txt');
%
xc = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/xc_san_fran.txt');
yc = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/yc_san_fran.txt');
%
for i = 1: num_radial
ev(i, 1) = round(ev_hh(i, 3));
ev(i, 2) = round(ev_hv(i, 3));
ev(i, 3) = round(ev_vv(i, 3));
ev(i, 4) = round(ev_hh_hv_razao(i, 3));
ev(i, 5) = round(ev_hh_vv_razao(i, 3));
ev(i, 6) = round(ev_hv_vv_razao(i, 3));
ev(i, 7) = round(ev_span(i, 3));
end
nc = 7;
m = 450;
n = 600;
for i = 1: nc
	IM = zeros(m, n, nc);
end
for canal = 1 : nc
	for i = 1: num_radial
        		ik =  ev(i, canal);
			IM( yc(i, ik), xc(i, ik), canal) = 1;
	end
end
nt = 20
tempo = zeros(1, nt);
for i=1: nt
tic;
%[IF] = fus_media(IM, m, n, nc);
%[IF] = fus_pca(IM, m, n, nc);
%[IF] = fus_swt(IM, m, n, nc);
%[IF] = fus_dwt(IM, m, n, nc);
%[IF] = fus_roc(IM, m, n, nc);
[IF] = fus_svd(IM, m, n, nc);
tempo(i) = toc;
end
t= sum(tempo(1:nt)) / nt;
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
imshow(II)
% plot fusion
[xpixel, ypixel, valor] = find(IF > 0);
%plot edge evidences hh(1), hv(2) e vv(3)
%[xpixel, ypixel, valor] = find(IM(:, :, 7) > 0);
%
axis on
hold on;

dpixel = size(xpixel);
for i= 1: dpixel(1)
			plot(ypixel(i), xpixel(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end
