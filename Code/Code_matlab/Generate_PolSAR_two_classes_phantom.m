function [phantom] = Generate_PolSAR_two_classes_phantom(S,L,m,n)
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m
n
ns = n/2
phantom = zeros(m,n,9);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regions:
% class 1
class_1_samples = m*ns;
% class 2
class_2_samples = m*ns;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class 1:
% Sigma
% We take a valid sigma matrix
Sigma1 = S(:,:,1);
Sigma2 = S(:,:,2);

[S_class_1] = cwishart_variates(Sigma1,L,class_1_samples);
%representative
%R1=mean(S_class_1(1,1,:));
%R2=mean(S_class_1(1,2,:));
%R3=mean(S_class_1(1,3,:));
%R4=mean(S_class_1(2,1,:));
%R5=mean(S_class_1(2,2,:));
%R6=mean(S_class_1(2,3,:));
%R7=mean(S_class_1(3,1,:));
%R8=mean(S_class_1(3,2,:));
%R9=mean(S_class_1(3,3,:));
%R_class_1 = [R1,R2,R3;R4,R5,R6;R7,R8,R9];

% Class 2:
[S_class_2] = cwishart_variates(Sigma2,L,class_2_samples);
%representative
%R1=mean(S_class_2(1,1,:));
%R2=mean(S_class_2(1,2,:));
%R3=mean(S_class_2(1,3,:));
%R4=mean(S_class_2(2,1,:));
%R5=mean(S_class_2(2,2,:));
%R6=mean(S_class_2(2,3,:));
%R7=mean(S_class_2(3,1,:));
%R8=mean(S_class_2(3,2,:));
%R9=mean(S_class_2(3,3,:));
%R_class_2 = [R1,R2,R3;R4,R5,R6;R7,R8,R9];


%background right
[S_class_1] = cwishart_variates(Sigma1,L,class_1_samples); 
phantom(1:m,ns + 1:n,1) = reshape(S_class_1(1,1,:),m,ns);
phantom(1:m,ns + 1:n,2) = reshape(S_class_1(2,2,:),m,ns);
phantom(1:m,ns + 1:n,3) = reshape(S_class_1(3,3,:),m,ns);
phantom(1:m,ns + 1:n,4) = reshape(real(S_class_1(1,2,:)),m,ns);
phantom(1:m,ns + 1:n,5) = reshape(imag(S_class_1(1,2,:)),m,ns);
phantom(1:m,ns + 1:n,6) = reshape(real(S_class_1(1,3,:)),m,ns);
phantom(1:m,ns + 1:n,7) = reshape(imag(S_class_1(1,3,:)),m,ns);
phantom(1:m,ns + 1:n,8) = reshape(real(S_class_1(2,3,:)),m,ns);
phantom(1:m,ns + 1:n,9) = reshape(imag(S_class_1(2,3,:)),m,ns);

%background left
[S_class_2] = cwishart_variates(Sigma2,L,class_2_samples); 
phantom(1:m,1:ns,1) = reshape(S_class_2(1,1,:),m,ns);
phantom(1:m,1:ns,2) = reshape(S_class_2(2,2,:),m,ns);
phantom(1:m,1:ns,3) = reshape(S_class_2(3,3,:),m,ns);
phantom(1:m,1:ns,4) = reshape(real(S_class_2(1,2,:)),m,ns);
phantom(1:m,1:ns,5) = reshape(imag(S_class_2(1,2,:)),m,ns);
phantom(1:m,1:ns,6) = reshape(real(S_class_2(1,3,:)),m,ns);
phantom(1:m,1:ns,7) = reshape(imag(S_class_2(1,3,:)),m,ns);
phantom(1:m,1:ns,8) = reshape(real(S_class_2(2,3,:)),m,ns);
phantom(1:m,1:ns,9) = reshape(imag(S_class_2(2,3,:)),m,ns);

% Representative should be the one used to generate the variables
%R(:,:,1) = R_class_1(:,:);
%R(:,:,2) = R_class_2(:,:); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
