clear all;
format long;
cd ..
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_art_grsl_2020_tengarss/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IT = zeros(nrows, ncols); 
IF = zeros(nrows, ncols); 
%
x0 = nrows / 2 + 120;
y0 = ncols / 2 - 150;
r = 100;
num_radial = 100;
t = linspace(0, 2 * pi, num_radial) ;
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ev_hh = load('/home/aborba/ufal_mack/Data/flev_r3_hh_evid_L_mu_14_100_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Data/flev_r3_hv_evid_L_mu_14_100_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Data/flev_r3_vv_evid_L_mu_14_100_pixel.txt');
%
xc = load('/home/aborba/ufal_mack/Data/xc_flevoland_r3.txt');
yc = load('/home/aborba/ufal_mack/Data/yc_flevoland_r3.txt');
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
nt = 20
tempo = zeros(1, nt);
for i=1: nt
tic;
%[IF] = fus_media(IM, m, n, nc);
%[IF] = fus_pca(IM, m, n, nc);
%[IF] = fus_swt(IM, m, n, nc);
%[IF] = fus_dwt(IM, m, n, nc);
%[IF] = fus_roc(IM, m, n, nc);
%[IF] = fus_maior_voto(IM, m, n, nc);
%[IF] = fus_svd(IM, m, n, nc);
tempo(i) = toc;
end
t= sum(tempo(1:nt)) / nt;
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
imshow(II)
% plot com fusion
%[xpixel, ypixel, valor] = find(IF > 0);
%plot das evidencias em cada canal
[xpixel, ypixel, valor] = find(IM(:, :, 3) > 0);
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
