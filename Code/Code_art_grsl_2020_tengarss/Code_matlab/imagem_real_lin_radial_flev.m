% Coded by Anderson Borba data: 01/07/2020 version 1.0
% Extract information from Flevoland image to edge detection evidences
% Article to appear 
% GRSL - IEEE Geoscience and Remote Sensing Letters 	
% Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
% 
% Descriptiom
% 1) Show flevoland with ROI and radial lines (Use show_Pauli)
% 2) Extract information in the 9 channels to radial lines (use Bresenham)
% 3) Print this information in txt files
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output 
% 1) Print this information in txt files
%
% Obs: 1) prints commands are commented with %  
%
clc       
clear       
close all 
format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
cd ..
cd ..
cd Data
% Read date
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_art_grsl_2020_tengarss/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAB
% show_Pauli coded by
% Coded in Matlab by Luis Gomez, July 2018 for getting result shown in:
% (2) D. Santana-Cedrés, L. Gomez, L. Alvarez and A. C. Frery,"Despeckling
% PolSAR images with a structure tensor filter"
% More infomation see function coded
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IT = zeros(nrows, ncols); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROI control
x0 = nrows / 2 + 90;
y0 = ncols / 2 - 450 ;
% Radial lenght variable
% r = 60
rd = 60;
re = 20;
r = rd + re;
num_radial = 100;
t = linspace(0, 2 * pi, num_radial) ;
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract Radial
const =  5 * max(max(max(II)));
MXC = zeros(num_radial, r);
MYC = zeros(num_radial, r);
MY  = zeros(num_radial, r, nc);
%for i = 1: num_radial
for i = 1: 64 % used to limited the image
%for i = 50: 64 % used to a strip fixed
	[myline, mycoords, outmat, XC, YC] = bresenham(IT, [x0, y0; xr(i), yr(i)], 0); 
	for canal = 1 :nc
		Iaux = S(:, :, canal);
		dim = length(XC);
		for j = 1: dim
			MXC(i, j) = YC(j);
			MYC(i, j) = XC(j);
			MY(i, j, canal)  = Iaux( XC(j), YC(j)) ;
	       		IT(XC(j), YC(j)) = const;
	       		II(XC(j), YC(j)) = const;
        	end
	end
end
r = 60
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
for i = 65: 100
	[myline, mycoords, outmat, XC, YC] = bresenham(IT, [x0, y0; xr(i), yr(i)], 0); 
	for canal = 1 :nc
		Iaux = S(:, :, canal);
		dim = length(XC);
		for j = 1: dim
			MXC(i, j) = YC(j);
			MYC(i, j) = XC(j);
			MY(i, j, canal)  = Iaux( XC(j), YC(j)) ;
	       		IT(XC(j), YC(j)) = const;
	       		II(XC(j), YC(j)) = const;
        	end
	end
end
imshow(II);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% return to r = 80 - lenght of the radial
r = 80
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print radials
%cd ..
%cd ..
%cd ..
%cd Data
%for canal = 1: nc 
%	fname = sprintf('real_flevoland_r2_%d.txt', canal);
%	fid = fopen(fname,'w');
%	for i = 1: num_radial
%		for j = 1: r
%                fprintf(fid,'%f ',MY(i, j, canal));
%	      	end
%    		fprintf(fid,'\n');
%        end
%        fclose(fid);       
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% command print (xc, yc)
%	fnamexc = sprintf('xc_flevoland_r2.txt');
%	fnameyc = sprintf('yc_flevoland_r2.txt');
%	fidxc = fopen(fnamexc,'w');
%	fidyc = fopen(fnameyc,'w');
%        for i = 1: num_radial
%		for j = 1: r
%	                fprintf(fidxc,'%f ', MXC(i,j));
%	                fprintf(fidyc,'%f ', MYC(i,j));
%	      	end
%    		fprintf(fidxc,'\n');
%    		fprintf(fidyc,'\n');
%	end
%	fclose(fidxc);       
%	fclose(fidyc);       
%cd ..
%cd Code/Code_art_grsl_2020_tengarss/Code_matlab

