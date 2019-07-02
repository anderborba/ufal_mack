clc         % clean screen
clear       % clear workspace
close all   % close all open plots
format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To load a .txt file in Matlab (with the above saved format) and write it
% to matrix V.:
cd ..
cd ..
cd Data
load AirSAR_Flevoland_Enxuto.mat
[nrows, ncols, nc] = size(S);
cd ..
cd Code/Code_matlab
for i =1: nrows
	for j = 1: ncols
     		I11(i, j)  = S(i, j, 1);
     		I22(i, j)  = S(i, j, 2);
     		I33(i, j)  = S(i, j, 3);
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = show_Pauli(S, 1, 0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 = nrows / 2 + 10;
y0 = ncols / 2 + 80;
r = 120;
num_radial = 200;
t = linspace(0, 2 * pi, num_radial) - pi / 2 ;
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
const =  5 * max(max(max(II)));
%radial = num_radial / 2;
for i = 1: num_radial
	[myline, mycoords, outmat, XT2, YT2] = bresenham(II, [x0, y0; xr(i), yr(i)], 0);
	dim = length(XT2);
	for j = 1: dim
	       II(XT2(j), YT2(j)) = const;
        end
end
imshow(II);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extrai retas radiais e as distribuicoes nas imagens reais nos canais (hh, hv, vv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% obs: cada canal produz seus proprios X, Y com dimensões diferentes!!!!
%% Mat com numero de colunas 400, para armazenar os X e Y com dim  variaveis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MY = zeros(num_radial, r, 3);
%MXC = zeros(num_radial, r, 3);
%MYC = zeros(num_radial, r, 3);
for canal = 1 : nc
	for i = 1: num_radial
		Iaux = S(:, :, canal);
		[myline, mycoords, outmat, XC, YC] = bresenham(Iaux, [x0, y0; xr(i), yr(i)], 0);
		dimc = length(XC);
		for j = 1: dimc
			MY(i, j, canal) = myline(j);
			MXC(i, j, canal) = XC(j);
			MYC(i, j, canal) = YC(j);
        	end
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Escreve em arquivo *.txt as informações das retas radiais nas imagens
% reais nos canais 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
cd ..
cd Data
for canal = 1: nc 
	fname = sprintf('real_flevoland_%d.txt', canal);
	fid = fopen(fname,'w');
	for i = 1: num_radial
		for j = 1: r
	                fprintf(fid,'%f ',MY(i, j, canal));
	      	end
    		fprintf(fid,'\n');
        end
        fclose(fid);       
end
for canal = 1: nc
	fnamexc = sprintf('xc_flevoland_%d.txt', canal);
	fnameyc = sprintf('yc_flevoland_%d.txt', canal);
	fidxc = fopen(fnamexc,'w');
	fidyc = fopen(fnameyc,'w');
	for i = 1: num_radial
		for j = 1: r
	                fprintf(fidxc,'%f ',MXC(i, j, canal));
	                fprintf(fidyc,'%f ',MYC(i, j, canal));
	      	end
    		fprintf(fidxc,'\n');
    		fprintf(fidyc,'\n');
        end
	fclose(fidxc);       
	fclose(fidyc);       
end
cd ..
cd Code/Code_matlab
