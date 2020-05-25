clear all;
format long;
%cd ..
%cd ..
%cd Data
%load AirSAR_Flevoland_Enxuto.mat
%[nrows, ncols, nc] = size(S);
%cd ..
%cd Code/Code_matlab
%for i =1: nrows
%	for j = 1: ncols
%     		I11(i, j)   = S(i, j, 1);
%     		I22(i, j)   = S(i, j, 2);
%     		I33(i, j)   = S(i, j, 3);
%     		SS(i, j, 1)  = sqrt(S(i, j, 4)^2 + S(i, j, 7)^2);
%     		SS(i, j, 2)  = sqrt(S(i, j, 5)^2 + S(i, j, 8)^2);
%     		SS(i, j, 3)  = sqrt(S(i, j, 6)^2 + S(i, j, 9)^2);
%	end
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IT = zeros(nrows, ncols); 
%IF = zeros(nrows, ncols); 

%x0 = nrows / 2 - 140;
%y0 = ncols / 2 - 200;
%r = 120;
%num_radial = 100;
%t = linspace(0, 2 * pi, num_radial) ;
%x = x0 + r .* cos(t);
%y = y0 + r .* sin(t);
%xr= round(x);
%yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%const =  5 * max(max(max(II)));
%MXC = zeros(num_radial, r);
%MYC = zeros(num_radial, r);
%MY = zeros(num_radial, r, nc);
%  Insere as linhas radiais
%const =  1
%for i = 1:4: num_radial
%	[myline, mycoords, outmat, XC, YC] = bresenham(IT, [x0, y0; xr(i), yr(i)], 0); 
%	for canal = 1 :nc
%		Iaux = S(:, :, canal);
%		dim = length(XC);
%		for j = 1: dim
%			MXC(i, j) = YC(j);
%			MYC(i, j) = XC(j);
%			MY(i, j, canal)  = Iaux( XC(j), YC(j)) ;
%	       		IT(XC(j), YC(j)) = const;
%	       		II(XC(j), YC(j)) = const;
%        	end
%	end
%end
%imshow(II);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ev_hh = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_hh_hv_param_razao.txt');
%ev_hv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_hh_vv_param_razao.txt');
%%%%% Cuidado esta repetido o canal%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ev_vv = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_hh_vv_param_razao.txt');
Ihh = load('/home/aborba/ufal_mack/Data/Phantom_nhfc_0.000_1_2_1.txt');
Ihv = load('/home/aborba/ufal_mack/Data/Phantom_nhfc_0.000_1_2_2.txt');
Ivv = load('/home/aborba/ufal_mack/Data/Phantom_nhfc_0.000_1_2_3.txt');
ev_hh = load('/home/aborba/ufal_mack/Data/evid_sim_nhfc_1_param_L_mu_14_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Data/evid_sim_nhfc_2_param_L_mu_14_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Data/evid_sim_nhfc_3_param_L_mu_14_pixel.txt');
%ev_hh_hv_pm = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_produto_mag_param_L_rho_1_2.txt'); 
%ev_hh_vv_pm = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_produto_mag_param_L_rho_1_3.txt'); 
%ev_hv_vv_pm = load('/home/aborba/ufal_mack/Data/evid_real_flevoland_produto_mag_param_L_rho_2_3.txt'); 

%ev_hh_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_2.txt');
%ev_hv_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_3.txt');
%xc = load('/home/aborba/ufal_mack/Data/xc_flevoland.txt');
%yc = load('/home/aborba/ufal_mack/Data/yc_flevoland.txt');
num_radial = 400;
for i = 1: num_radial 
ev(i, 1) = round(ev_hh(i, 3));
ev(i, 2) = round(ev_hv(i, 3));
ev(i, 3) = round(ev_vv(i, 3));
%ev(i, 4) = round(ev_hh_hv_pm(i, 3));
%ev(i, 5) = round(ev_hh_vv_pm(i, 3));
%ev(i, 6) = round(ev_hv_vv_pm(i, 3));
%ev(i, 5) = round(ev_hh_vv(i, 3));
%ev(i, 6) = round(ev_hv_vv(i, 3));
end
nc = 3;
m = 400;
n = 400;
for i = 1: nc
	IM = zeros(m, n, nc);
end
for canal = 1 : nc
	for i = 1: num_radial
			IM(i, ev(i, canal), canal) = 1;
	end
end
II = zeros(m, n);
Ihh=mat2gray(Ihh);
Ihh=imadjust(Ihh);
Ihv=mat2gray(Ihv);
Ihv=imadjust(Ihv);
Ivv=mat2gray(Ivv);
Ivv=imadjust(Ivv);
II=cat(3,abs(Ihh + Ivv), abs(Ihv), abs(Ihh - Ivv));
escala=mean2(II)*3;figure(1),imshow(imresize(II,1),[0,escala]);
imshow(II)
% plot com fusion
%[xpixel, ypixel, valor] = find(IF > 0);
%plot das evidencias em cada canal
[xpixel, ypixel, valor] = find(IM(:, :, 3) > 0);
%
axis on
hold on;
%
dpixel = size(xpixel);
for i= 1: dpixel(1)
			plot(ypixel(i), xpixel(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.0 1 0.85],...
    				'MarkerFaceColor', [0.0 1 0.85])
end	
%for i= 1: dpixel(1)
%			plot(ypixel(i), xpixel(i),'ro',...
%    				'LineWidth',1.0,...
%    				'MarkerSize',3.5,...
%    				'MarkerEdgeColor',[0.85 0.325 0.089],...
%    				'MarkerFaceColor', [0.85 0.325 0.089])
%end	