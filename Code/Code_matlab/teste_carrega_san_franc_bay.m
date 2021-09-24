clc         % clean screen
clear       % clear workspace
close all   % close all open plots
format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To load a .txt file in Matlab (with the above saved format) and write it
% to matrix V.:
%load SanFrancisco_Bay.mat
cd ..
cd ..
cd Data
load SanFrancisco_Bay.mat
%load AirSAR_Flevoland_Enxuto.mat
cd ..
cd Code/Code_matlab
M = 450;
N = 600;
for i =1: M
	for j = 1: N
     		I11(i, j)  = S(i, j, 1);
     		I22(i, j)  = S(i, j, 2);
     		I33(i, j)  = S(i, j, 3);
     		I12R(i, j) = S(i, j, 4);
     		I12I(i, j) = S(i, j, 5);
     		I13R(i, j) = S(i, j, 6);
     		I13I(i, j) = S(i, j, 7);
     		I23R(i, j) = S(i, j, 8);
     		I23I(i, j) = S(i, j, 9);
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I11 = mat2gray(I11);
I11 = imadjust(I11);
I22 = mat2gray(I22);
I22 = imadjust(I22);
I33 = mat2gray(I33);
I33 = imadjust(I33);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I12R = mat2gray(I12R);
I12R = imadjust(I12R);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I12I = mat2gray(I12I);
I12I = imadjust(I12I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I13R = mat2gray(I13R);
I13R = imadjust(I13R);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I13I = mat2gray(I13I);
I13I = imadjust(I13I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I23R = mat2gray(I23R);
I23R = imadjust(I23R);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I23I = mat2gray(I23I);
I23I = imadjust(I23I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%my_vertices = [500 500;400 600;400 700;500 800;600 800;700 700; 700 600];
%h = drawpolygon('Position',my_vertices);
%%%%%%%%%%%%%%%%%%%  ROI mar azul %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I11ROIA = imcrop(I11,[50 50 100 100]);
I22ROIA = imcrop(I22,[50 50 100 100]);
I33ROIA = imcrop(I33,[50 50 100 100]);

cr_a(1) = corr2(I11ROIA, I22ROIA);
cr_a(2) = corr2(I11ROIA, I33ROIA);
cr_a(3) = corr2(I22ROIA, I33ROIA);
%%%%%%%%%%%%%%%%%%  ROI floresta red %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I11ROIB = imcrop(I11,[245 295 295 345]);
I22ROIB = imcrop(I22,[245 295 295 345]);
I33ROIB = imcrop(I33,[245 295 295 345]);

cr_b(1) = corr2(I11ROIB, I22ROIB);
cr_b(2) = corr2(I11ROIB, I33ROIB);
cr_b(3) = corr2(I22ROIB, I33ROIB);
%%%%%%%%%%%%%%%%%%  ROI  zona urbana yellow %%%%%%%%%%%%%%%%%%%%%%%%%%
I11ROIC = imcrop(I11,[375 375 425 425]);
I22ROIC = imcrop(I22,[375 375 425 425]);
I33ROIC = imcrop(I33,[375 375 425 425]);

cr_c(1) = corr2(I11ROIC, I22ROIC);
cr_c(2) = corr2(I11ROIC, I33ROIC);
cr_c(3) = corr2(I22ROIC, I33ROIC);

II = cat(3, abs(I11 + I33), abs(I22), abs(I11 - I33));
escale = mean2(II) * 3;
imshow(imresize(II, 1),[0, escale]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line([50,   50],[50,  100],'Color','b','LineWidth', 2)
line([50,  100],[100, 100],'Color','b','LineWidth', 2)
line([100, 100],[100,  50],'Color','b','LineWidth', 2)
line([100,  50],[50 ,  50],'Color','b','LineWidth', 2)
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line([245, 245],[295, 345],'Color','r','LineWidth', 2)
line([245, 295],[345, 345],'Color','r','LineWidth', 2)
line([295, 295],[295, 345],'Color','r','LineWidth', 2)
line([245, 295],[295, 295],'Color','r','LineWidth', 2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line([375, 375],[375, 425],'Color','y','LineWidth', 2)
line([375, 425],[425, 425],'Color','y','LineWidth', 2)
line([425, 425],[425, 375],'Color','y','LineWidth', 2)
line([425, 375],[375, 375],'Color','y','LineWidth', 2)

figure(1); 
hold on;
[nrow, ncol] = size(I11ROIB);
%cd ..
%cd ..
%cd Data
%%for i= 1: nrow
%%	I11ROIB(i, j)
%%	I22ROIB(i, j)
%%	I33ROIB (i, j)
%end
%[nrow_A, ncol_A] = size(I11ROIA);
%[nrow_B, ncol_B] = size(I11ROIB);
%[nrow_C, ncol_C] = size(I11ROIC);
%fname_A11 = sprintf('roi_mar_azul_11.txt');
%fname_A22 = sprintf('roi_mar_azul_22.txt');
%fname_A33 = sprintf('roi_mar_azul_33.txt');
%fid_A11 = fopen(fname_A11,'w');
%fid_A22 = fopen(fname_A22,'w');
%fid_A33 = fopen(fname_A33,'w');
%fname_B11 = sprintf('roi_floresta_red_11.txt');
%fname_B22 = sprintf('roi_floresta_red_22.txt');
%fname_B33 = sprintf('roi_floresta_red_33.txt');
%fid_B11 = fopen(fname_B11,'w');
%fid_B22 = fopen(fname_B22,'w');
%fid_B33 = fopen(fname_B33,'w');
%fname_C11 = sprintf('roi_zona_urbana_yellow_11.txt');
%fname_C22 = sprintf('roi_zona_urbana_yellow_22.txt');
%fname_C33 = sprintf('roi_zona_urbana_yellow_33.txt');
%fid_C11 = fopen(fname_C11,'w');
%fid_C22 = fopen(fname_C22,'w');
%fid_C33 = fopen(fname_C33,'w');
%fprintf(fid,'%d %d\r\n', Height, Width);
%for i = 1: nrow_A
%	for j = 1: ncol_A
%                fprintf(fid_A11,'%f ',I11ROIA(i, j));
%                fprintf(fid_A22,'%f ',I22ROIA(i, j));
%                fprintf(fid_A33,'%f ',I33ROIA(i, j));
%        end
%        fprintf(fid_A11,'\r\n');
%        fprintf(fid_A22,'\r\n');
%        fprintf(fid_A33,'\r\n');
%end
%for i = 1: nrow_B
%	for j = 1: ncol_B
%                fprintf(fid_B11,'%f ',I11ROIB(i, j));
%                fprintf(fid_B22,'%f ',I22ROIB(i, j));
%                fprintf(fid_B33,'%f ',I33ROIB(i, j));
%        end
%        fprintf(fid_B11,'\r\n');
%        fprintf(fid_B22,'\r\n');
%        fprintf(fid_B33,'\r\n');
%end
%for i = 1: nrow_C
%	for j = 1: ncol_C
%                fprintf(fid_C11,'%f ',I11ROIC(i, j));
%                fprintf(fid_C22,'%f ',I22ROIC(i, j));
%                fprintf(fid_C33,'%f ',I33ROIC(i, j));
%        end
%        fprintf(fid_C11,'\r\n');
%        fprintf(fid_C22,'\r\n');
%        fprintf(fid_C33,'\r\n');
%end
%fclose(fid_A11);       
%fclose(fid_A22);       
%fclose(fid_A33);       
%fclose(fid_B11);       
%fclose(fid_B22);       
%fclose(fid_B33);       
%fclose(fid_C11);       
%fclose(fid_C22);       
%fclose(fid_C33);       
%cd ..
%cd Code/Code_matlab
%II = cat(3, abs(I11 + I33), abs(I22), abs(I11 - I33));
%II = cat(2, abs(I11 + I33), abs(I22));
%II = cat(2, II            , abs(I11 - I33));
%figure(1);
%imshow(imresize(II, 1),[0, escale]);
