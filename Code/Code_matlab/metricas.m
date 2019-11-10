function [RMSE,PFE,MAE,dent,CORR,SNR,PSNR,QI,SSIM,MSSIM,SVDQM,SC,LMSE,VIF,PSNR_HVSM,PSNR_HVS] = metricas(imt, imf)
% Root mean square error (RMSE)
[m,n] = size(imt);
RMSE = sqrt(sum((imt(:)-imf(:)).^2)/(m*n));

%percentage fit error (PFE)
PFE = 100*norm(imt(:)-imf(:))/norm(imt(:));

% mean absolute error (MAE)
MAE = sum(sqrt((imt(:)-imf(:)).^2))/(m*n);

% defference entropy H
dent = abs(entropy(imt)-entropy(imf));

% Correlation (CORR)
Rtf = sum(sum(imt.*imf));
Rt = sum(sum(imt.*imt));
Rf = sum(sum(imf.*imf));
CORR = 2*Rtf/(Rt+Rf);

% signal to noise ration (SNR)
st = mean(mean((double(imt)).^2));
ntf =  mean(mean((double(imt-imf)).^2));
SNR = 10*log10(st/ntf);

% Peak signal to noise Ratio (PSNR)
L = 256;
PSNR = 10*log10(L^2/RMSE);

% mutual information(MI)
%MI = minf2(imt,imf);

% universal image quality index (QI)
QI = uiqi(imt,imf,8);

% structural similarity based image quality measurement
K = [0.01 0.03];
L = 255;
SSIM = ssim(imt,imf,K,L);

% Multi-scale SSIM
MSSIM = mssim_index(imt,imf,K,L);


%SVD-based Image Quality Measure
SVDQM = SVDQualityMeasure(imt,imf,8);

%structural content
SC = structural_content(imt,imf);

% LMSE(Laplacian Mean Squared Error
LMSE = LMS_error(imt,imf);

%VIF the visual information fidelity measure between the two images
VIF = vifp_mscale(imt,imf);

% PSNR-HVS-M and PSNR-HVS image quality measures
[PSNR_HVSM, PSNR_HVS] = psnrhvsm(imt,imf,8);


%===================================================================== 
 
function[MI] = minf2(im1,im2)
%%% MUTUALINFORMATION: compute the mutual information between two images
%%%   mutualinformation( im1, im2 )
%%%     im1: grayscale or color image, or 1-D signal
%%%     im2: must be same size as im1

   bins = [0:8:255];
   N    = length(bins);

   %%% JOINT HISTOGRAM
   joint  = zeros( N, N );
   X1     = im1(:);
   X2     = im2(:);
   maxval = max( [X1 ; X2] );
   X1     = round( X1 * (N-1)/maxval ) + 1
   X2     = round( X2 * (N-1)/maxval ) + 1 
   for k = 1 : length(X1)
      joint( X1(k), X2(k) ) = joint( X1(k), X2(k) ) + 1;
   end
   joint = joint / sum(joint(:));

   %%% MARGINALS
   NX2 = sum( joint );
   NX1 = sum( joint' );

   %%% MUTUAL INFORMATION
   MI = 0;
   for i = 1 : N
      for j = 1 : N
         if( joint(i,j)>eps & NX1(i)>eps & NX2(j)> eps )
            MI = MI + joint(i,j) * log( joint(i,j)/(NX1(i)*NX2(j)) );
         end
      end
   end


%======================================================================

function[quality] = uiqi(img1,img2,block_size)
N = block_size.^2;
sum2_filter = ones(block_size);

img1_sq   = img1.*img1;
img2_sq   = img2.*img2;
img12 = img1.*img2;

img1_sum   = filter2(sum2_filter, img1, 'valid');
img2_sum   = filter2(sum2_filter, img2, 'valid');
img1_sq_sum = filter2(sum2_filter, img1_sq, 'valid');
img2_sq_sum = filter2(sum2_filter, img2_sq, 'valid');
img12_sum = filter2(sum2_filter, img12, 'valid');

img12_sum_mul = img1_sum.*img2_sum;
img12_sq_sum_mul = img1_sum.*img1_sum + img2_sum.*img2_sum;
numerator = 4*(N*img12_sum - img12_sum_mul).*img12_sum_mul;
denominator1 = N*(img1_sq_sum + img2_sq_sum) - img12_sq_sum_mul;
denominator = denominator1.*img12_sq_sum_mul;

quality_map = ones(size(denominator));
index = (denominator1 == 0) & (img12_sq_sum_mul ~= 0);
quality_map(index) = 2*img12_sum_mul(index)./img12_sq_sum_mul(index);
index = (denominator ~= 0);
quality_map(index) = numerator(index)./denominator(index);
quality = mean2(quality_map);

%==========================================================================

function[mssim] = ssim(img1,img2,K,L)
C1 = (K(1)*L)^2;
C2 = (K(2)*L)^2;
window = fspecial('gaussian', 11, 1.5);
window = window/sum(sum(window));
img1 = double(img1);
img2 = double(img2);

mu1   = filter2(window, img1, 'valid');
mu2   = filter2(window, img2, 'valid');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;
sigma2_sq = filter2(window, img2.*img2, 'valid') - mu2_sq;
sigma12 = filter2(window, img1.*img2, 'valid') - mu1_mu2;

if (C1 > 0 & C2 > 0)
   ssim_map = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
else
   numerator1 = 2*mu1_mu2 + C1;
   numerator2 = 2*sigma12 + C2;
	denominator1 = mu1_sq + mu2_sq + C1;
   denominator2 = sigma1_sq + sigma2_sq + C2;
   ssim_map = ones(size(mu1));
   index = (denominator1.*denominator2 > 0);
   ssim_map(index) = (numerator1(index).*numerator2(index))./(denominator1(index).*denominator2(index));
   index = (denominator1 ~= 0) & (denominator2 == 0);
   ssim_map(index) = numerator1(index)./denominator1(index);
end
mssim = mean2(ssim_map);

%==========================================================================

function[scaMeasure] = SVDQualityMeasure(refImg, distImg, blkSize)
%Program for SVD-based Image Quality Measure

% Aleksandr Shnayderman, Alexander Gusev, and Ahmet M. Eskicioglu,
% "An SVD-Based Grayscale Image Quality Measure for Local and Global Assessment",
% IEEE TRANSACTIONS ON IMAGE PROCESSING, VOL. 15, NO. 2, FEBRUARY 2006.

%Parameters
% refImg        -   Input Reference Gray Image
% distImg       -   Input Distorted Gray Image
% blkSize       -   Window size for block processing
% graMeasure    -   Graphical Image quality measure
% scaMeasure    -   Numerical Image quality measure

k = size(refImg, 1);
blkx = blkSize;
blky = blkSize;
blockwise1 = MatDec(refImg,blkx);
blockwise2 = MatDec(distImg,blkx);
[blkx blky imgx imgy] = size(blockwise1);
graMeasure = zeros(imgx,imgy);
blockwise1 = double(blockwise1);
blockwise2 = double(blockwise2);

for i=1:imgx
    for j=1:imgy
        temp_in_image = blockwise1(:,:,i,j);temp_in_image=temp_in_image(:);
        original_img = reshape(temp_in_image,blkx,blky);
        temp_dist_image = blockwise2(:,:,i,j);temp_dist_image=temp_dist_image(:);
        distorted_img = reshape(temp_dist_image,blkx,blky);
        graMeasure(i,j) = sqrt(sum((svd(original_img)-svd(distorted_img)).^2));
    end
end
graMeasure = round((graMeasure/max(max(graMeasure)))*255);
scaMeasure = sum(sum(abs(graMeasure-median(median(graMeasure)))))/((k/blkx).^2);

function out = MatDec(inImg, blkSize)
%This program decomposes an image into blocks.
%Parameters
% inImg         -   Input Gray Image
% blkSize       -   Window size for block processing
% out           -   Output 4 dimensional matrix with blocks.

[m,n]=size(inImg);
r3=m/blkSize;
c3=n/blkSize;
q4=0;
q1=0;

for i=1:r3
    for j=1:c3
        for s=1:blkSize
            for k=1:blkSize
                p3=s+q4;
                q2=k+q1;
                out(s,k,i,j)=inImg(p3,q2);
            end
        end
        q1=q1+blkSize;
    end
    q4=q4+blkSize;q1=0;
end

%==========================================================================
    
    function[SC] = structural_content(A,B)
    % SC (Structural Content)    
    Bs = sum(sum(B.^2));
    Pk = sum(sum(A.^2));
    if (Bs == 0)
        SC = Inf;
    else
        SC=Pk/sum(sum(B.^2)); % SC
    end

%========================================================================

 function[LMSE] = LMS_error(A,B)
% LMSE(Laplacian Mean Squared Error
    OP=4*del2(A);
    LMSE=sum(sum((OP-4*del2(B)).^2))/sum(sum(OP.^2));

%======================================================================

function [mssim] = mssim_index(img1, img2,K,L)
% Multi-scale SSIM
%  Input:
%   img1 - first image
%   img2 - second image
%  Output:   mssim - mssim value

nlevs = 5;

% Use Analysis Low Pass filter from Biorthogonal 9/7 Wavelet
lod = [0.037828455507260; -0.023849465019560;  -0.110624404418440; ...
    0.377402855612830; 0.852698679008890;   0.377402855612830;  ...
    -0.110624404418440; -0.023849465019560; 0.037828455507260];
lpf = lod*lod';
lpf = lpf/sum(lpf(:));

img1 = double(img1);img2 = double(img2);
window = fspecial('gaussian',11,1.5);
window = window/sum(sum(window));
ssim_v = zeros(nlevs,1);
ssim_r = zeros(nlevs,1);
% Scale 1 is the original image
comp_ssim = ssim_index_modified(img1,img2,K,L);
ssim_v(1) = comp_ssim(2);
ssim_r(1) = comp_ssim(3);

% Compute SSIM for scales 2 through 5
for s=1:nlevs-1    
    % Low Pass Filter
    img1 = imfilter(img1,lpf,'symmetric','same');
    img2 = imfilter(img2,lpf,'symmetric','same');    
    img1 = img1(1:2:end,1:2:end);
    img2 = img2(1:2:end,1:2:end);

    comp_ssim = ssim_index_modified(img1,img2,K,L);
    ssim_m = comp_ssim(1);         % Mean Component only needed for scale 5
    ssim_v(s+1) = comp_ssim(2);
    ssim_r(s+1) = comp_ssim(3);   
end
alpha = 0.1333;
beta = [0.0448 0.2856 0.3001 0.2363 0.1333]';
gamma = [0.0448 0.2856 0.3001 0.2363 0.1333]';

comp = [ssim_m^alpha prod(ssim_v.^beta) prod(ssim_r.^gamma)];
mssim = prod(comp);


function[composite_mean_vec] = ssim_index_modified(img1, img2, K,L)

[M N] = size(img1);
 window = fspecial('gaussian', 11, 1.5);	%
                                %

C1 = (K(1)*L)^2;
C2 = (K(2)*L)^2;
window = window/sum(sum(window));
img1 = double(img1);
img2 = double(img2);

mu1   = filter2(window, img1, 'valid');
mu2   = filter2(window, img2, 'valid');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, img1.*img1, 'valid') - mu1_sq;
sigma2_sq = filter2(window, img2.*img2, 'valid') - mu2_sq;
sigma1 = real(sqrt(sigma1_sq));
sigma2 = real(sqrt(sigma2_sq));
sigma12 = filter2(window, img1.*img2, 'valid') - mu1_mu2;

if (C1 > 0 && C2 > 0)
   M = (2*mu1_mu2 + C1)./(mu1_sq + mu2_sq + C1);
   V = (2*sigma1.*sigma2 + C2)./(sigma1_sq + sigma2_sq + C2);
   R = (sigma12 + C2/2)./(sigma1.*sigma2+C2/2);   
else
   ssim_ln = 2*mu1_mu2;
   ssim_ld = mu1_sq + mu2_sq;
   M = ones(size(mu1));
   index_l = (ssim_ld>0);
   M(index_l) = ssim_ln(index_l)./ssim_ld(index_l);
   
   ssim_cn = 2*sigma1.*sigma2;
   ssim_cd = sigma1_sq + sigma2_sq;
   V = ones(size(mu1));
   index_c = (ssim_cd>0);
   V(index_c) = ssim_cn(index_c)./ssim_cd(index_c);
   
   ssim_sn = sigma12;
   ssim_sd = sigma1.*sigma2;
   R = ones(size(mu1));
   index1 = sigma1>0;
   index2 = sigma2>0;
   index_s = (index1.*index2>0);
   R(index_s) = ssim_sn(index_s)./ssim_sd(index_s);
   index_s = (index1.*not(index2)>0);
   R(index_s) = 0;
   index_s = (not(index1).*index2>0);
   R(index_s) = 0;
end
composite_mean_vec = [mean2(M) mean2(V) mean2(R)];

%======================================================================

 function[vifp] = vifp_mscale(ref,dist)

% Input : (1) img1: The reference image as a matrix
%         (2) img2: The distorted image (order is important)
% Output: (1) VIF the visual information fidelity measure between the two images

% Advanced Usage:
%    Users may want to modify the parameters in the code. 
%    (1) Modify sigma_nsq to find tune for your image dataset.


sigma_nsq=2;
num=0;
den=0;
for scale=1:4
   
    N=2^(4-scale+1)+1;
    win=fspecial('gaussian',N,N/5);    
    if (scale >1)
        ref=filter2(win,ref,'valid');
        dist=filter2(win,dist,'valid');
        ref=ref(1:2:end,1:2:end);
        dist=dist(1:2:end,1:2:end);
    end
    
    mu1   = filter2(win, ref, 'valid');
    mu2   = filter2(win, dist, 'valid');
    mu1_sq = mu1.*mu1;
    mu2_sq = mu2.*mu2;
    mu1_mu2 = mu1.*mu2;
    sigma1_sq = filter2(win, ref.*ref, 'valid') - mu1_sq;
    sigma2_sq = filter2(win, dist.*dist, 'valid') - mu2_sq;
    sigma12 = filter2(win, ref.*dist, 'valid') - mu1_mu2;
    
    sigma1_sq(sigma1_sq<0)=0;
    sigma2_sq(sigma2_sq<0)=0;
    
    g=sigma12./(sigma1_sq+1e-10);
    sv_sq=sigma2_sq-g.*sigma12;
    
    g(sigma1_sq<1e-10)=0;
    sv_sq(sigma1_sq<1e-10)=sigma2_sq(sigma1_sq<1e-10);
    sigma1_sq(sigma1_sq<1e-10)=0;
    
    g(sigma2_sq<1e-10)=0;
    sv_sq(sigma2_sq<1e-10)=0;
    
    sv_sq(g<0)=sigma2_sq(g<0);
    g(g<0)=0;
    sv_sq(sv_sq<=1e-10)=1e-10;    
    
     num=num+sum(sum(log10(1+g.^2.*sigma1_sq./(sv_sq+sigma_nsq))));
     den=den+sum(sum(log10(1+sigma1_sq./sigma_nsq)));    
end
vifp=num/den;

%=========================================================================

function [p_hvs_m, p_hvs] = psnrhvsm(img1, img2, step)
% Calculation of PSNR-HVS-M and PSNR-HVS image quality measures
%
% PSNR-HVS-M is Peak Signal to Noise Ratio taking into account 
% Contrast Sensitivity Function (CSF) and between-coefficient   
% contrast masking of DCT basis functions
% PSNR-HVS is Peak Signal to Noise Ratio taking into account only CSF 

% PSNR-HVS-M:
% [1] Nikolay Ponomarenko, Flavia Silvestri, Karen Egiazarian, Marco Carli, 
%     Jaakko Astola, Vladimir Lukin, "On between-coefficient contrast masking 
%     of DCT basis functions", CD-ROM Proceedings of the Third International 
%     Workshop on Video Processing and Quality Metrics for Consumer Electronics 
%     VPQM-07, Scottsdale, Arizona, USA, 25-26 January, 2007, 4 p.
%
% PSNR-HVS:
% [2] K. Egiazarian, J. Astola, N. Ponomarenko, V. Lukin, F. Battisti, 
%     M. Carli, New full-reference quality metrics based on HVS, CD-ROM 
%     Proceedings of the Second International Workshop on Video Processing 
%     and Quality Metrics, Scottsdale, USA, 2006, 4 p.
% Input : (1) img1: the first image being compared
%         (2) img2: the second image being compared
%         (3) wstep: step of 8x8 window to calculate DCT 
%             coefficients. Default value is 8.
%
% Output: (1) p_hvs_m: the PSNR-HVS-M value between 2 images.
%             If one of the images being compared is regarded as 
%             perfect quality, then PSNR-HVS-M can be considered as the
%             quality measure of the other image.
%             If compared images are visually undistingwished, 
%             then PSNR-HVS-M = 100000.
%         (2) p_hvs: the PSNR-HVS value between 2 images.
%
% Default Usage:
%   Given 2 test images img1 and img2, whose dynamic range is 0-255
%   [p_hvs_m, p_hvs] = psnrhvsm(img1, img2);
%
% See the results:
%   p_hvs_m  % Gives the PSNR-HVS-M value
%   p_hvs    % Gives the PSNR-HVS value

LenXY=size(img1);LenY=LenXY(1);LenX=LenXY(2);

CSFCof  = [1.608443, 2.339554, 2.573509, 1.608443, 1.072295, 0.643377, 0.504610, 0.421887;
           2.144591, 2.144591, 1.838221, 1.354478, 0.989811, 0.443708, 0.428918, 0.467911;
           1.838221, 1.979622, 1.608443, 1.072295, 0.643377, 0.451493, 0.372972, 0.459555;
           1.838221, 1.513829, 1.169777, 0.887417, 0.504610, 0.295806, 0.321689, 0.415082;
           1.429727, 1.169777, 0.695543, 0.459555, 0.378457, 0.236102, 0.249855, 0.334222;
           1.072295, 0.735288, 0.467911, 0.402111, 0.317717, 0.247453, 0.227744, 0.279729;
           0.525206, 0.402111, 0.329937, 0.295806, 0.249855, 0.212687, 0.214459, 0.254803;
           0.357432, 0.279729, 0.270896, 0.262603, 0.229778, 0.257351, 0.249855, 0.259950];
% see an explanation in [2]

MaskCof = [0.390625, 0.826446, 1.000000, 0.390625, 0.173611, 0.062500, 0.038447, 0.026874;
           0.694444, 0.694444, 0.510204, 0.277008, 0.147929, 0.029727, 0.027778, 0.033058;
           0.510204, 0.591716, 0.390625, 0.173611, 0.062500, 0.030779, 0.021004, 0.031888;
           0.510204, 0.346021, 0.206612, 0.118906, 0.038447, 0.013212, 0.015625, 0.026015;
           0.308642, 0.206612, 0.073046, 0.031888, 0.021626, 0.008417, 0.009426, 0.016866;
           0.173611, 0.081633, 0.033058, 0.024414, 0.015242, 0.009246, 0.007831, 0.011815;
           0.041649, 0.024414, 0.016437, 0.013212, 0.009426, 0.006830, 0.006944, 0.009803;
           0.019290, 0.011815, 0.011080, 0.010412, 0.007972, 0.010000, 0.009426, 0.010203];
% see an explanation in [1]

S1 = 0; S2 = 0; Num = 0;
X=1;Y=1;
while Y <= LenY-7
  while X <= LenX-7 
    A = img1(Y:Y+7,X:X+7);
    B = img2(Y:Y+7,X:X+7);
    A_dct = dct2(A); B_dct = dct2(B);
    MaskA = maskeff(A,A_dct,MaskCof);
    MaskB = maskeff(B,B_dct,MaskCof);
    if MaskB > MaskA
      MaskA = MaskB;
    end
    X = X + step;
    for k = 1:8
      for l = 1:8
        u = abs(A_dct(k,l)-B_dct(k,l));
        S2 = S2 + (u*CSFCof(k,l)).^2;    % PSNR-HVS
        if (k~=1) | (l~=1)               % See equation 3 in [1]
          if u < MaskA/MaskCof(k,l) 
            u = 0;
          else
            u = u - MaskA/MaskCof(k,l);
          end
        end
        S1 = S1 + (u*CSFCof(k,l)).^2;    % PSNR-HVS-M
        Num = Num + 1;
      end
    end
  end
  X = 1; Y = Y + step;
end

if Num ~=0
  S1 = S1/Num;S2 = S2/Num;
  if S1 == 0 
    p_hvs_m = 100000; % img1 and img2 are visually undistingwished
  else
    p_hvs_m = 10*log10(255*255/S1);
  end
  if S2 == 0  
    p_hvs = 100000; % img1 and img2 are identical
  else
    p_hvs = 10*log10(255*255/S2);
  end
end

    function[m] = maskeff(z,zdct,MaskCof)  
% Calculation of Enorm value (see [1])
m = 0;
for k = 1:8
  for l = 1:8
    if (k~=1) | (l~=1)
      m = m + (zdct(k,l).^2) * MaskCof(k,l);
    end
  end
end
pop=vari(z);
if pop ~= 0
  pop=(vari(z(1:4,1:4))+vari(z(1:4,5:8))+vari(z(5:8,5:8))+vari(z(5:8,1:4)))/pop;
end
m = sqrt(m*pop)/32;   % sqrt(m*pop/16/64)

function[d] = vari(AA)
  d=var(AA(:))*length(AA(:));
  %========================================================================


