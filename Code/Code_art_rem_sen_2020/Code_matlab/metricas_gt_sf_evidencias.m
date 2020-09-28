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
num_radial = 25;
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
GT = zeros(m, n);
GT = load('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/gt_san_fran.txt');
r = 120;
for j = 1: num_radial
	erro_f1(j) = erro_radial(xc, yc, GT, IM(:, :, 1), r, j);
  erro_f2(j) = erro_radial(xc, yc, GT, IM(:, :, 2), r, j);
	erro_f3(j) = erro_radial(xc, yc, GT, IM(:, :, 3), r, j);
	erro_f4(j) = erro_radial(xc, yc, GT, IM(:, :, 4), r, j);
	erro_f5(j) = erro_radial(xc, yc, GT, IM(:, :, 5), r, j);
	erro_f6(j) = erro_radial(xc, yc, GT, IM(:, :, 6), r, j);
	erro_f7(j) = erro_radial(xc, yc, GT, IM(:, :, 7), r, j);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nk = 10;
freq_f1 = zeros(1, nk + 1);
freq_f2 = zeros(1, nk + 1);
freq_f3 = zeros(1, nk + 1);
freq_f4 = zeros(1, nk + 1);
freq_f5 = zeros(1, nk + 1);
freq_f6 = zeros(1, nk + 1);
freq_f7 = zeros(1, nk + 1);
for k= 1: nk
	freq_f1(k + 1) = frequencia(erro_f1, k, num_radial);
	freq_f2(k + 1) = frequencia(erro_f2, k, num_radial);
	freq_f3(k + 1) = frequencia(erro_f3, k, num_radial);
	freq_f4(k + 1) = frequencia(erro_f4, k, num_radial);
	freq_f5(k + 1) = frequencia(erro_f5, k, num_radial);
	freq_f6(k + 1) = frequencia(erro_f6, k, num_radial);
	freq_f7(k + 1) = frequencia(erro_f7, k, num_radial);
end
%
fname = sprintf('/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Data/metricas_evid_sf.txt', canal);
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
for i = 1: nk
	fprintf(fid,'%f ', freq_f7(i));
end
fprintf(fid,'\n');
fclose(fid);
