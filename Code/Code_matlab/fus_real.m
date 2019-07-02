% Programado por AAB - versao 1.0 **/**/20**
clear all;
format long;
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
cd ..
cd Code/Code_matlab
[nrows, ncols, nc] = size(S);
show_Pauli(S, 1, 0);
%
x0 = nrows / 2;
y0 = ncols / 2;
%
for i = 1: num_radial
	S(, ,1) = 1;
%	img_hv(XT1_hv(evidencias_hv(i, 3)), YT1_hv(evidencias_hv(i, 3))) = 1;
%	img_vv(XT1_vv(evidencias_vv(i, 3)), YT1_vv(evidencias_vv(i, 3))) = 1;
end
%img_hh = 1 - img_hh;
%img_hv = 1 - img_hv;
%img_vv = 1 - img_vv;
%
%im1 = img_hh;
%im2 = img_hv;
%im3 = img_vv;
%figure(1);
%subplot(121);imshow(im1,[]);
%subplot(122);imshow(im2,[]);
%figure(2);
%imshow(im3,[]);
