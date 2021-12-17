function [phantom] = Generate_PolSAR_two_classes_phantom_rectangle(S, L, m, n, img1, rows1, cols1, img2, rows2, cols2)
%Phantom_generator function
% 
% To generate 500 x 500 PolSAR phantoms
% S:        vector of matrices with the valid S for each class
%           valid S:S must be definite positive
% L:        scalar with an unique L value
% m:        height of the phantom
% n:        width of the phantom
% This version is not parametrized, so use always m = n = 500.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script works wiht the main script:
% Polsar_two_classes_phantom_Convex_sum.m
% Used to get results in the publication:
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAB - Adaptado para a phantom em coordenadas polares da flor.                     Data:  21/11/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ns = n/2;
ns = n;
phantom = zeros(m,n,9);
aux1     = zeros(m,n,9);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regions:
% class 1
class_1_samples = m*ns;
% class 2
class_2_samples = m*ns;
% class strip
class_strip_samples = m*ns;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sigma
% We take a valid sigma matrix
Sigma1 = S(:,:,1);
Sigma2 = S(:,:,2);
%Sigma2 = S(:,:,1);
%Sigma1 = S(:,:,2);
Sigma_strip = 0.5 * (S(:,:,1) + S(:,:,2));
% Class 1:
[S_class_1] = cwishart_variates(Sigma1,L,class_1_samples);
% Class strip:
[S_class_strip] = cwishart_variates(Sigma_strip,L,class_strip_samples);
% Class strip:
[S_class_2] = cwishart_variates(Sigma2,L,class_2_samples);
%background rose outside
phantom(1:m, 1:n,1) = reshape(S_class_1(1,1,:),m, n);
phantom(1:m, 1:n,2) = reshape(S_class_1(2,2,:),m, n);
phantom(1:m, 1:n,3) = reshape(S_class_1(3,3,:),m, n);
phantom(1:m, 1:n,4) = reshape(real(S_class_1(1,2,:)),m, n);
phantom(1:m, 1:n,5) = reshape(imag(S_class_1(1,2,:)),m, n);
phantom(1:m, 1:n,6) = reshape(real(S_class_1(1,3,:)),m, n);
phantom(1:m, 1:n,7) = reshape(imag(S_class_1(1,3,:)),m, n);
phantom(1:m, 1:n,8) = reshape(real(S_class_1(2,3,:)),m, n);
phantom(1:m, 1:n,9) = reshape(imag(S_class_1(2,3,:)),m, n);
%background rose inside
aux1(1:m,1:n,1) = reshape(S_class_strip(1,1,:),m,n);
aux1(1:m,1:n,2) = reshape(S_class_strip(2,2,:),m,n);
aux1(1:m,1:n,3) = reshape(S_class_strip(3,3,:),m,n);
aux1(1:m,1:n,4) = reshape(real(S_class_strip(1,2,:)),m,n);
aux1(1:m,1:n,5) = reshape(imag(S_class_strip(1,2,:)),m,n);
aux1(1:m,1:n,6) = reshape(real(S_class_strip(1,3,:)),m,n);
aux1(1:m,1:n,7) = reshape(imag(S_class_strip(1,3,:)),m,n);
aux1(1:m,1:n,8) = reshape(real(S_class_strip(2,3,:)),m,n);
aux1(1:m,1:n,9) = reshape(imag(S_class_strip(2,3,:)),m,n);
L1 = length(rows1);
L2 = length(cols1);
for i= 1: L1
	phantom(rows1(i), cols1(i),1) = aux1(rows1(i), cols1(i),1) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),2) = aux1(rows1(i), cols1(i),2) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),3) = aux1(rows1(i), cols1(i),3) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),4) = aux1(rows1(i), cols1(i),4) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),5) = aux1(rows1(i), cols1(i),5) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),6) = aux1(rows1(i), cols1(i),6) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),7) = aux1(rows1(i), cols1(i),7) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),8) = aux1(rows1(i), cols1(i),8) + img1(rows1(i), cols1(i));
	phantom(rows1(i), cols1(i),9) = aux1(rows1(i), cols1(i),9) + img1(rows1(i), cols1(i));
end
% 
aux2(1:m,1:n,1) = reshape(S_class_2(1,1,:),m,n);
aux2(1:m,1:n,2) = reshape(S_class_2(2,2,:),m,n);
aux2(1:m,1:n,3) = reshape(S_class_2(3,3,:),m,n);
aux2(1:m,1:n,4) = reshape(real(S_class_2(1,2,:)),m,n);
aux2(1:m,1:n,5) = reshape(imag(S_class_2(1,2,:)),m,n);
aux2(1:m,1:n,6) = reshape(real(S_class_2(1,3,:)),m,n);
aux2(1:m,1:n,7) = reshape(imag(S_class_2(1,3,:)),m,n);
aux2(1:m,1:n,8) = reshape(real(S_class_2(2,3,:)),m,n);
aux2(1:m,1:n,9) = reshape(imag(S_class_2(2,3,:)),m,n);
L1 = length(rows2);
L2 = length(cols2);
for i= 1: L1
	phantom(rows2(i), cols2(i),1) = aux2(rows2(i), cols2(i),1) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),2) = aux2(rows2(i), cols2(i),2) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),3) = aux2(rows2(i), cols2(i),3) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),4) = aux2(rows2(i), cols2(i),4) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),5) = aux2(rows2(i), cols2(i),5) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),6) = aux2(rows2(i), cols2(i),6) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),7) = aux2(rows2(i), cols2(i),7) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),8) = aux2(rows2(i), cols2(i),8) + img2(rows2(i), cols2(i));
	phantom(rows2(i), cols2(i),9) = aux2(rows2(i), cols2(i),9) + img2(rows2(i), cols2(i));
end
%imshow(img)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
% AAB - Modify in 22/11/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
