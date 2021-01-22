clear all;
format long;
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IT  = ones(nrows, ncols);
II  = zeros(nrows, ncols);
II2 = zeros(nrows, ncols);
IF  = zeros(nrows, ncols);
%
x0 = nrows / 2 - 140;
y0 = ncols / 2 - 200;
r = 120;
num_radial = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ev_hh = load('/home/aborba/ufal_mack/Code/Code_igarss_2021/Data/evidence_flev_hh.txt');
ev_hv = load('/home/aborba/ufal_mack/Code/Code_igarss_2021/Data/evidence_flev_hv.txt');
ev_vv = load('/home/aborba/ufal_mack/Code/Code_igarss_2021/Data/evidence_flev_vv.txt');
%
xc = load('/home/aborba/ufal_mack/Code/Code_igarss_2021/Data/xc_flevoland.txt');
yc = load('/home/aborba/ufal_mack/Code/Code_igarss_2021/Data/yc_flevoland.txt');
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
%[IF] = fus_pca(IM, m, n, nc);
[IF] = fus_swt(IM, m, n, nc);
%[IF] = fus_dwt(IM, m, n, nc);
%[IF] = fus_roc(IM, m, n, nc);
%[IF] = fus_svd(IM, m, n, nc);
% configuracao para fusao
%[nyedge, nxedge] = find(IF~=0);
%nedge = size(find(IF~=0), 1);
% configuracao para os canais
[nyedge, nxedge] = find(IM(:,:, 3)~=0);
nedge = size(find(IM(:,:, 3)~=0), 1);
% Extract Radial
%MXC = zeros(nedge, r);
%MYC = zeros(nedge, r);
%MY  = zeros(nedge, r, nc);
ca = zeros(nedge, 1);
sa = zeros(nedge, 1);
x = zeros(nedge, 1);
y = zeros(nedge, 1);
h = zeros(nedge, 1);
for i = 1: nedge
	[myline, mycoords, outmat, XC, YC] = bresenham(IT, [x0, y0; nxedge(i), nyedge(i)], 0); 
	dim = length(XC);
	for j = 1: dim
        	II(XC(j), YC(j)) = 1;
        end
end
GT = zeros(m, n);
cd ..
cd Data
GT = load('gt_flevoland.txt');
cd ..
cd Code_matlab
for i = 1: nedge
	v = [nxedge(i) - x0, nyedge(i) - y0];
	h(i) = norm(v);
	ca(i) = (nxedge(i) - x0) / h(i);
        sa(i) = (nyedge(i) - y0) / h(i);
	x(i) = x0 + r * ca(i);
        y(i) = y0 + r * sa(i);
	%[mylinefus, mycoords, outmat, XC, YC] = bresenham(IF, [x0, y0; x(i), y(i)], 0); 
	[mylinefus, mycoords, outmat, XC, YC] = bresenham(IM(:, :, 3), [x0, y0; x(i), y(i)], 0); 
	[mylinegt, mycoords, outmat, XC, YC] = bresenham(GT, [x0, y0; x(i), y(i)], 0); 
	bf   = find(mylinefus > 0);
	lbf  = length(bf);
	bgt  = find(mylinegt > 0);
	lbgt = length(bgt);
	for k=1: lbf
		for j=1: lbgt
			aux1 = XC(bf(k)) - XC(bgt(j));
			aux2 = YC(bf(k)) - YC(bgt(j));
			erro_j_aux(j) = sqrt(aux1^2 + aux2^2);
		end
		erro_aux(k) = min(erro_j_aux);
	end
	erro(i) = min(erro_aux);
	dim = length(XC);
	for j = 1: dim
        	II2(XC(j), YC(j)) = 1;
        end
end
m(1) = met_vet_d_mae(erro, nedge);
m(2) = met_vet_d_rmse(erro, nedge);
m(3) = met_vet_d_inf(erro, nedge);
% Read GT
% 
%
%Iaux = IM(:, :, 3);
%Iaux = IF;
%IB = mat_conv_bin(Iaux, m, n);
%v_conf = mat_conf(GT, IB, m, n);
%[m] = met_class(v_conf);
%v_g = reshape(GT, m * n, 1);
%v_e = reshape(IB, m * n, 1);
%[C] = confusionmat(v_g, v_e)
%m = met_class_igarss(v_conf);
