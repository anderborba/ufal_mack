clear all;
format long;
ev_hh = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_1.txt');
ev_hv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_2.txt');
ev_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_3.txt');
%ev_hh_hv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_1.txt');
%ev_hh_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_2.txt');
%ev_hv_vv = load('/home/aborba/git_ufal_mack/Data/evid_real_flevoland_produto_3.txt');
xc = load('/home/aborba/git_ufal_mack/Data/xc_flevoland.txt');
yc = load('/home/aborba/git_ufal_mack/Data/yc_flevoland.txt');
num_radial = 100;
for i = 1: num_radial 
ev(i, 1) = round(ev_hh(i, 3));
ev(i, 2) = round(ev_hv(i, 3));
ev(i, 3) = round(ev_vv(i, 3));
%ev(i, 4) = round(ev_hh_hv(i, 3));
%ev(i, 5) = round(ev_hh_vv(i, 3));
%ev(i, 6) = round(ev_hv_vv(i, 3));
end
nc = 3;
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
%[IF] = fus_media(IM, m, n, nc);
%[IF] = fus_pca(IM, m, n, nc);
%[IF] = fus_swt(IM, m, n, nc);
%[IF] = fus_roc(IM, m, n, nc);
[IF] = fus_svd(IM, m, n, nc);
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
x0 = m / 2 - 140;
y0 = n / 2 - 200;
lex = x0 - 20;
lrx = x0 + 180;
hty = y0 - 210;
hby = y0 + 60;

IM_hh = IM(lex: lrx, hty: hby ,1);
IM_hv = IM(lex: lrx, hty: hby ,2);
IM_vv = IM(lex: lrx, hty: hby ,3);
IF_crop = IF(lex: lrx, hty: hby);


