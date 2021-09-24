% Coded by Anderson Borba data: 01/07/2020 version 1.0
% Extract information from Flevoland image to edge detection evidences
% Article: Fusion of Evidences in Intensities Channels for Edge Detection in PolSAR Images 
% GRSL - IEEE Geoscience and Remote Sensing Letters 	
% Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
% 
% Description
% 1) Show flevoland with ROI and radial lines (Use show_Pauli)
% 2) Extract information in the 9 channels to radial lines (use Bresenham)
% 3) Print this information in txt files
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output 
% 1) Print this information in txt files
%
% Obs: 1) prints commands are commented with %  
%      2) contact email: anderborba@gmail.com
clc       
clear       
close all 
format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
cd Data
% Read date
load SanFrancisco_Bay.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAB
% show_Pauli coded by
% Coded in Matlab by Luis Gomez, July 2018 for getting result shown in:
% (2) D. Santana-Cedrés, L. Gomez, L. Alvarez and A. C. Frery,"Despeckling
% PolSAR images with a structure tensor filter"
% More infomation see function coded
II = show_Pauli(S, 1, 0);
%
Ihh = S(:,:,1);       
Ihh = mat2gray(Ihh);       
Ihh = imadjust(Ihh);
escale = mean2(Ihh) * 3;
%escale = mean2(Ihh) * 3;
imshow(Ihh,[0, escale]);
%imshow(Ihh);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%imshow(II);
axis on;
hold on;
impixelinfo;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

