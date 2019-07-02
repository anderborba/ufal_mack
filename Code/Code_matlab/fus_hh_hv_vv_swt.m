%function[] = SWTimfuse1L_demo()
% Image fusion by (one level)discrete stationary wavelet transform  - demo
% by VPS Naidu, MSDF Lab, NAL, Bangalore
close all;
clear all;
%home;

% insert images
%im1 = double(imread('saras51.jpg'));
%im2 = double(imread('saras52.jpg'));
m = 400;
n = 400;
ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_nhfc.txt');
ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_nhfc.txt');
ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_nhfc.txt');
%
ev_1 = ev_hh(:, 3);
ev_2 = ev_hv(:, 3);
ev_3 = ev_vv(:, 3);
%
%
E1 = zeros(m, n);
E2 = zeros(m, n);
E3 = zeros(m, n);
for(i = 1: m)
	E1(i, round(ev_hh(i, 3)))      = 1;
	E2(i, round(ev_hv(i, 3)))      = 1;
	E3(i, round(ev_vv(i, 3)))      = 1;
end
im1 = E1;
im2 = E2;
im3 = E3;
figure(1);
%subplot(121);
imshow(im1,[]);
figure(2);
%subplot(122);
imshow(im2,[]);
figure(3);
imshow(im3,[]);
% image decomposition using discrete stationary wavelet transform
[A1,H1,V1,D1] = swt2(im1,1,'sym2');
[A2,H2,V2,D2] = swt2(im2,1,'sym2');
[A3,H3,V3,D3] = swt2(im3,1,'sym2');

% fusion start ideia 1
%AfL1 = 0.5*(A1L1+A2L1);
%D = (abs(H1L1)-abs(H2L1))>=0;
%HfL1 = D.*H1L1 + (~D).*H2L1;
%D = (abs(V1L1)-abs(V2L1))>=0;
%VfL1 = D.*V1L1 + (~D).*V2L1;
%D = (abs(D1L1)-abs(D2L1))>=0;
%DfL1 = D.*D1L1 + (~D).*D2L1;
% fusion start ideia 2
Af   = (A1 + A2 + A3) / 3.0;
AUX1 = max(H1  , H2);
Hf   = max(AUX1, H3);
AUX2 = max(V1  , V2);
Vf   = max(AUX2, V3);
AUX3 = max(D1  , D2);
Df   = max(AUX3, D3);

% fused image
imf = iswt2(Af,Hf,Vf,Df,'sym2');
figure(4); imshow(imf);
