clear all;
format long;
cd ..
cd ..
cd ..
cd Data
load SanFrancisco_Bay.mat
[m, n, nc] = size(S);
cd ..
cd Code/Code_art_grsl_2020_tengarss/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%i%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GT = zeros(m, n);
%figure(1), imshow(I255);
%figure(2), imshow(IG);
%%%%%%%%%%% ROIs %%%%%%%%%%%%%%%%%%
imshow(II)
%
axis on
hold on;
impixelinfo;

x0 = 194;
y0 = 361;
xf = 255;
yf = 355;
[myline, input_dados, outmat, x, y ] = bresenham(II, [x0, y0; xf, yf], 0); 
dim = length(x)
for i= 1: dim
GT(x(i), y(i)) = 1;
plot(y(i), x(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
x0 = 191;
y0 = 420;
xf = 185;
yf = 365;
[myline, input_dados, outmat, x, y ] = bresenham(II, [x0, y0; xf, yf], 0); 
dim = length(x)
for i= 1: dim
GT(x(i), y(i)) = 1;
plot(y(i), x(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
x0 = 194;
y0 = 361;
xf = 185;
yf = 365;
[myline, input_dados, outmat, x, y ] = bresenham(II, [x0, y0; xf, yf], 0); 
dim = length(x)
for i= 1: dim
GT(x(i), y(i)) = 1;
plot(y(i), x(i),'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
cd ..
cd ..
cd ..
cd Data
fname = sprintf('gt_san_fran_r1.txt');
fid = fopen(fname,'w');
for i = 1: m
	for j = 1: n
               fprintf(fid,'%f ', GT(i,j));
        end
        fprintf(fid,'\r\n');
end
fclose(fid); 
cd ..
cd Code/Code_art_grsl_2020_tengarss/Code_matlab
