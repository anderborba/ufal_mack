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
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
imshow(II)
%
axis on
hold on;
impixelinfo;

x0 = m / 2 + 305;
y0 = n / 2 + 77;
xf = m / 2 + 237;
yf = n / 2 + 77;
[myline, input_dados, outmat, x, y ] = bresenham(II, [x0, y0; xf, yf], 0); 
dim = length(x);
for i= 1: dim
GT(x(i), y(i)) = 1;
plot(y(i), x(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
x0 = m / 2 + 243;
y0 = n / 2 + 20;
xf = m / 2 + 237;
yf = n / 2 + 77;
[myline, input_dados, outmat, x, y ] = bresenham(II, [x0, y0; xf, yf], 0); 
dim = length(x);
for i= 1: dim
GT(x(i), y(i)) = 1;
plot(y(i), x(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
%cd ..
%cd ..
%cd ..
%cd Data
%fname = sprintf('gt_flevoland_r3.txt');
%fid = fopen(fname,'w');
%for i = 1: m
%	for j = 1: n
%        	fprintf(fid,'%f ', GT(i,j));
%        end
%        fprintf(fid,'\r\n');
%end
%fclose(fid); 
%cd ..
%cd Code/Code_art_grsl_2020_tengarss/Code_matlab
