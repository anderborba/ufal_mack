% Coded by Anderson Borba data: 01/07/2020 version 1.0
% Fusion of Evidences in Intensities Channels for Edge Detection in PolSAR Images
% GRSL - IEEE Geoscience and Remote Sensing Letters
% Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
%
% Description
% 1) Calculate metricas to Flevoland
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output
% 1) Print this information in txt files
% Obs: 1) Prints commands are commented with %
%      2) Contact email: anderborba@gmail.com
%      3) Change *.txt to Flevoland region II
clear all;
format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ihh = load('/home/aborba/ufal_mack/Data/Phantom_gamf_0.000_1_2_1.txt');
Ihv = load('/home/aborba/ufal_mack/Data/Phantom_gamf_0.000_1_2_2.txt');
Ivv = load('/home/aborba/ufal_mack/Data/Phantom_gamf_0.000_1_2_3.txt');
ev_hh = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_1_param_mu_14_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_2_param_mu_14_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_3_param_mu_14_pixel.txt');
%
%xc = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/xc_san_fran.txt');
%yc = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/yc_san_fran.txt');
num_radial = 400;
for i = 1: num_radial
ev(i, 1) = round(ev_hh(i, 3));
ev(i, 2) = round(ev_hv(i, 3));
ev(i, 3) = round(ev_vv(i, 3));
end
nc = 3;
m = 400;
n = 400;
for i = 1: nc
	IM = zeros(m, n, nc);
end
xc = zeros(m, n);
yc = zeros(m, n);
for i=1: m
	for j=1: n
		xc(i, j) = j;
		yc(i, j) = i;
	end
end
for canal = 1 : nc
	for i = 1: num_radial
			IM(i, ev(i, canal), canal) = 1;
	end
end
[IF1] = fus_media(IM, m, n, nc);
[IF2] = fus_pca(IM, m, n, nc);
[IF3] = fus_swt(IM, m, n, nc);
[IF4] = fus_dwt(IM, m, n, nc);
[IF5] = fus_roc(IM, m, n, nc);
[IF6] = fus_svd(IM, m, n, nc);
GT = zeros(m, n);
for i=1: m
	GT(i,200) = 1;
end
r = 400;
nk = 10;
for j = 1: num_radial
	erro_f1(j) = erro_radial(xc, yc, GT, IF1, r, j);
	erro_f2(j) = erro_radial(xc, yc, GT, IF2, r, j);
	erro_f3(j) = erro_radial(xc, yc, GT, IF3, r, j);
	erro_f4(j) = erro_radial(xc, yc, GT, IF4, r, j);
	erro_f5(j) = erro_radial(xc, yc, GT, IF5, r, j);
	erro_f6(j) = erro_radial(xc, yc, GT, IF6, r, j);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nk = 10;
freq_f1 = zeros(1, nk + 1);
freq_f2 = zeros(1, nk + 1);
freq_f3 = zeros(1, nk + 1);
freq_f4 = zeros(1, nk + 1);
freq_f5 = zeros(1, nk + 1);
freq_f6 = zeros(1, nk + 1);
for k= 1: nk
	freq_f1(k + 1) = frequencia(erro_f1, k, num_radial);
	freq_f2(k + 1) = frequencia(erro_f2, k, num_radial);
	freq_f3(k + 1) = frequencia(erro_f3, k, num_radial);
	freq_f4(k + 1) = frequencia(erro_f4, k, num_radial);
	freq_f5(k + 1) = frequencia(erro_f5, k, num_radial);
	freq_f6(k + 1) = frequencia(erro_f6, k, num_radial);
end
%
fname = sprintf('/home/aborba/ufal_mack/Data/metricas_fusao_simulado_14_pixel.txt', canal);
fid = fopen(fname,'w');
for i = 1: nk
	fprintf(fid,'%f ', freq_f1(i));
end
fprintf(fid,'\n');
for i = 1: nk
	fprintf(fid,'%f ', freq_f2(i));
end
fprintf(fid,'\n');
for i = 1: nk
	fprintf(fid,'%f ', freq_f3(i));
end
fprintf(fid,'\n');
for i = 1: nk
	fprintf(fid,'%f ', freq_f4(i));
end
fprintf(fid,'\n');
for i = 1: nk
	fprintf(fid,'%f ', freq_f5(i));
end
fprintf(fid,'\n');
for i = 1: nk
	fprintf(fid,'%f ', freq_f6(i));
end
fprintf(fid,'\n');
fclose(fid);
