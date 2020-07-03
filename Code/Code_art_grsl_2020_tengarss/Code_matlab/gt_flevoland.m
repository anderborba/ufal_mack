clear all;
format long;
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_matlab
for i =1: nrows
	for j = 1: ncols
     		I11(i, j)   = S(i, j, 1);
     		I22(i, j)   = S(i, j, 2);
     		I33(i, j)   = S(i, j, 3);
     		SS(i, j, 1)  = sqrt(S(i, j, 4)^2 + S(i, j, 7)^2);
     		SS(i, j, 2)  = sqrt(S(i, j, 5)^2 + S(i, j, 8)^2);
     		SS(i, j, 3)  = sqrt(S(i, j, 6)^2 + S(i, j, 9)^2);
	end
end
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

%dpixel = size(xpixel);
%for i= 1: dpixel(1)
%			plot(ypixel(i), xpixel(i),'ro',...
%    				'LineWidth',1.0,...
%    				'MarkerSize',3.5,...
%    				'MarkerEdgeColor',[0.85 0.325 0.089],...
%    				'MarkerFaceColor', [0.85 0.325 0.089])
%end	
%for i= 181:220
%plot(i, 287,'ro',...
%    				'LineWidth',1.0,...
%    				'MarkerSize',3.5,...
%    				'MarkerEdgeColor',[0.85 0.325 0.089],...
%    				'MarkerFaceColor', [0.85 0.325 0.089])
%end	
%for i= 221:268
%plot(i, 286,'ro',...
%    				'LineWidth',1.0,...
%    				'MarkerSize',3.5,...
%    				'MarkerEdgeColor',[0.85 0.325 0.089],...
%    				'MarkerFaceColor', [0.85 0.325 0.089])
%end	
for i= 159:310
GT(287, i) = 1;
plot(i, 287,'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
for j= 288:330
GT(j, 159) = 1;	
plot(159, j,'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
for i= 159:310
GT(331, i) = 1;
plot(i, 331,'ro',...
    				'LineWidth',1.0,...
    				'MarkerSize',3.5,...
    				'MarkerEdgeColor',[0.85 0.325 0.089],...
    				'MarkerFaceColor', [0.85 0.325 0.089])
end	
for j= 288:331
GT(j, 310) = 1;
plot(310, j,'ro',...
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
