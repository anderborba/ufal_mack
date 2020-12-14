clear all;
format long;
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IT = zeros(nrows, ncols);
IF = zeros(nrows, ncols);
%
x0 = nrows / 2 - 140;
y0 = ncols / 2 - 200;
r = 120;
num_radial = 100;
t = linspace(0, 2 * pi, num_radial) ;
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ev_hh = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_1_param_L_mu_14_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_2_param_L_mu_14_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_3_param_L_mu_14_pixel.txt');
%
xc = load('/home/aborba/ufal_mack/Data/xc_flevoland.txt');
yc = load('/home/aborba/ufal_mack/Data/yc_flevoland.txt');
for i = 1: num_radial
	ev(i, 1) = round(ev_hh(i, 3));
	ev(i, 2) = round(ev_hv(i, 3));
	ev(i, 3) = round(ev_vv(i, 3));
end
nc = 3;
m = 750;
n = 1024;
for i = 1: nc
	IM = zeros(m, n, nc);
end
for canal = 1 : nc
	for i = 1: num_radial
        		ik =  ev(i, canal);
			IM( yc(i, ik), xc(i, ik), canal) = 1;
	end
end
%[IF] = fus_media(IM, m, n, nc);
[IF] = fus_pca(IM, m, n, nc);
%[IF] = fus_swt(IM, m, n, nc);
%[IF] = fus_dwt(IM, m, n, nc);
%[IF] = fus_roc(IM, m, n, nc);
%[IF] = fus_maior_voto(IM, m, n, nc);
%[IF] = fus_svd(IM, m, n, nc);
% Read GT
GT = zeros(m, n);
cd ..
cd ..
cd Data
GT = load('gt_flevoland.txt');
cd ..
cd Code/Code_matlab
%
Iaux = IM(:, :, 2);
IB = mat_conv_bin(Iaux, m, n);
v_g = reshape(GT, m * n, 1);
v_e = reshape(Iaux, m * n, 1);
[C] = confusionmat(v_g, v_e)
[m] = met_class(v_conf);
