clear all;
format long;
cd ..
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_art_grsl_2020_tengarss/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = 750;
n = 1024;
GT = zeros(m, n);
%figure(1), imshow(I255);
%figure(2), imshow(IG);
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
imshow(II)
%
axis on
hold on;
impixelinfo;

x0 = 422;
y0 = 35;
xf = 499;
yf = 57;
[myline, input_dados, outmat, x, y ] = bresenham(II, [x0, y0; xf, yf], 0); 
dim = length(x)
for i= 1: dim
%GT(30, i) = 1;
plot(y(i), x(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
%cd ..
%cd ..
%cd Data
%fname = sprintf('gt_flevoland.txt');
%fid = fopen(fname,'w');
%for i = 1: m
%	for j = 1: n
%                fprintf(fid,'%f ', GT(i,j));
%        end
%        fprintf(fid,'\r\n');
%end
%fclose(fid); 
%cd ..
%cd Code/Code_matlab
