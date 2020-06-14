clear all;
format long;
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ihh = load('/home/aborba/ufal_mack/Data/Phantom_gamf_0.000_1_2_1.txt');
Ihv = load('/home/aborba/ufal_mack/Data/Phantom_gamf_0.000_1_2_2.txt');
Ivv = load('/home/aborba/ufal_mack/Data/Phantom_gamf_0.000_1_2_3.txt');
ev_hh = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_1_param_L_mu_14_pixel.txt');
ev_hv = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_2_param_L_mu_14_pixel.txt');
ev_vv = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_3_param_L_mu_14_pixel.txt');
ev_hh_hv_razao = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_hh_hv_razao_param_tau_rho_14_pixel.txt');
ev_hh_vv_razao = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_hh_vv_razao_param_tau_rho_14_pixel.txt');
ev_hv_vv_razao = load('/home/aborba/ufal_mack/Data/evid_sim_gamf_hv_vv_razao_param_tau_rho_14_pixel.txt');
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
ev(i, 4) = round(ev_hh_hv_razao(i, 3));
ev(i, 5) = round(ev_hh_vv_razao(i, 3));
ev(i, 6) = round(ev_hv_vv_razao(i, 3));
%ev(i, 4) = round(ev_hh_hv_pm(i, 3));
%ev(i, 5) = round(ev_hh_vv_pm(i, 3));
%ev(i, 6) = round(ev_hv_vv_pm(i, 3));
%ev(i, 5) = round(ev_hh_vv(i, 3));
%ev(i, 6) = round(ev_hv_vv(i, 3));
end
nc = 6;
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
    				%'MarkerEdgeColor',[0.0 1 0.85],...
    				%'MarkerFaceColor', [0.0 1 0.85])
for i= 1: dpixel(1)
			plot(ypixel(i), xpixel(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.75 1. 0.75],...
    				'MarkerFaceColor', [0.75 1.0 0.75])
end	
%for i= 1: dpixel(1)
%			plot(ypixel(i), xpixel(i),'ro',...
%    				'LineWidth',1.0,...
%    				'MarkerSize',3.5,...
%    				'MarkerEdgeColor',[0.85 0.325 0.089],...
%    				'MarkerFaceColor', [0.85 0.325 0.089])
%end	
