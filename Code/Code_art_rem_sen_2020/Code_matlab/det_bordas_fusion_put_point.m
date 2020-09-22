clear all;
format long;
cd ..
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_art_rem_sen_2020/Code_matlab
for i =1: nrows
	for j = 1: ncols
     		I11(i, j)   = S(i, j, 1);
     		I22(i, j)   = S(i, j, 2);
     		I33(i, j)   = S(i, j, 3);
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IT = zeros(nrows, ncols);
IF = zeros(nrows, ncols);

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
const =  5 * max(max(max(II)));
MXC = zeros(num_radial, r);
MYC = zeros(num_radial, r);
MY = zeros(num_radial, r, nc);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ev_hh = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_1_param_L_mu_14_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_2_param_L_mu_14_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_3_param_L_mu_14_pixel.txt');
ev_hh_hv_razao = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_hh_hv_param_razao_rho_tau_14_pixel.txt');
ev_hh_vv_razao = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_hh_vv_param_razao_rho_tau_14_pixel.txt');
ev_hv_vv_razao = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_hv_vv_param_razao_rho_tau_14_pixel.txt');
ev_hh_hv_prod_mag  = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_produto_mag_param_L_rho_1_2_14_pixel.txt');
ev_hh_vv_prod_mag  = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_produto_mag_param_L_rho_1_3_25_pixel.txt');
ev_hv_vv_prod_mag  = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_produto_mag_param_L_rho_2_3_14_pixel.txt');
ev_span  = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_span_mu_media_14_pixel.txt');
%
xc = load('/home/aborba/ufal_mack/Data/xc_flevoland.txt');
yc = load('/home/aborba/ufal_mack/Data/yc_flevoland.txt');
%num_radial = 100;
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
m = 750;
n = 1024;
%x0 = m / 2 + 10;
%y0 = n / 2 + 80;
%x0 = m / 2 - 140;
%y0 = n / 2 - 200;
for i = 1: nc
	IM = zeros(m, n, nc);
end
for canal = 1 : nc
	for i = 1: num_radial
        		ik =  ev(i, canal);
			IM( yc(i, ik), xc(i, ik), canal) = 1;
	end
end
%figure(1), imshow(I255);
%figure(2), imshow(IG);
nt = 20
tempo = zeros(1, nt);
for i=1: nt
tic;
%[IF] = fus_media(IM, m, n, nc);
%[IF] = fus_pca(IM, m, n, nc);
[IF] = fus_swt(IM, m, n, nc);
%[IF] = fus_dwt(IM, m, n, nc);
%[IF] = fus_roc(IM, m, n, nc);
%[IF] = fus_svd(IM, m, n, nc);
tempo(i) = toc;
end
t= sum(tempo(1:nt)) / nt;
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
%x0 = m / 2 - 140;
%y0 = n / 2 - 200;
%lex = x0 - 20;
%lrx = x0 + 180;
%hty = y0 - 210;
%hby = y0 + 60;

imshow(II)
% plot com fusion
[xpixel, ypixel, valor] = find(IF > 0);
%plot das evidencias em cada canal
%[xpixel, ypixel, valor] = find(IM(:, :, 10) > 0);
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

%for i=1: nrows
%	for j=1: ncols
%%		if IF(i, j) ~= 0
%%%		if IM(i, j, 3) ~= 0
%			plot(xpixel(j), ypixel(i),'ro',...
%    				'LineWidth',1,...
%    				'MarkerSize',3.5,...
%    				'MarkerEdgeColor',[0.85 0.325 0.089],...
%    				'MarkerFaceColor', [0.85 0.325 0.089])
%%		end
%	end
%end
