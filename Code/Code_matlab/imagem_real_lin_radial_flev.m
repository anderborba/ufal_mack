clt         % clean screen
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
IT = zeros(nrows, ncols); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% preparando a amostra para os canais complexos %%%
%S(:,:,1) = ones(nrows, ncols);
%aux1(1, 1, 1) = sum(sum(S(1:2, 1:2,1)))/4;
%for j = 2: ncols - 1
%	aux1(1, j, 1) = sum(sum(S(1:2, j-1:j+1,1)))/6;
%end
%aux1(1, ncols, 1) = sum(sum(S(1:2, ncols-1:ncols,1)))/4;
%for i =2: nrows - 1
%	for j = 2: ncols - 1
%		aux1(i, j, 1) = sum(sum(S(i-1:i+1, j-1:j+1,1)))/9;
%	end
%end
%aux1(nrows, 1, 1) = sum(sum(S(nrows-1:nrows, 1:2,1)))/4;
%for j = 2: ncols - 1
%	aux1(nrows, j, 1) = sum(sum(S(nrows -1:nrows, j-1:j+1,1)))/6;
%end
%aux1(nrows, ncols, 1) = sum(sum(S(nrows-1:nrows, ncols-1:ncols,1)))/4;
%for i = 2: nrows - 1
%	aux1(i, 1, 1) = sum(sum(S(i-1:i+1, 1:2,1)))/6;
%	aux1(i, ncols, 1) = sum(sum(S(i-1:i+1, ncols-1:ncols,1)))/6;
%end
%
%aux2(1, 1, 1) = sum(sum(S(1:2, 1:2,2)))/4;
%for j = 2: ncols - 1
%	aux2(1, j, 1) = sum(sum(S(1:2, j-1:j+1,2)))/6;
%end
%aux2(1, ncols, 1) = sum(sum(S(1:2, ncols-1:ncols,2)))/4;
%for i =2: nrows - 1
%	for j = 2: ncols - 1
%		aux2(i, j, 1) = sum(sum(S(i-1:i+1, j-1:j+1,2)))/9;
%	end
%end
%aux2(nrows, 1, 1) = sum(sum(S(nrows-1:nrows, 1:2,2)))/4;
%for j = 2: ncols - 1
%	aux2(nrows, j, 1) = sum(sum(S(nrows -1:nrows, j-1:j+1,2)))/6;
%end
%aux2(nrows, ncols, 1) = sum(sum(S(nrows-1:nrows, ncols-1:ncols,2)))/4;
%for i = 2: nrows - 1
%	aux2(i, 1, 1) = sum(sum(S(i-1:i+1, 1:2,2)))/6;
%	aux2(i, ncols, 1) = sum(sum(S(i-1:i+1, ncols-1:ncols,2)))/6;
%end
%
%for i =1: nrows
%	for j = 1: ncols
%		SS(i, j, 1) = SS(i, j, 1) / sqrt(aux1(i,j,1)^2 * aux2(i,j,1)^2);
%	end
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0 = nrows / 2 - 140;
y0 = ncols / 2 - 200;
r = 120;
num_radial = 100;
t = linspace(0, 2 * pi, num_radial) ;
x = x0 + r .* cos(t);
y = y0 + r .* sin(t);
xr= round(x);
yr= round(y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
const =  5 * max(max(max(II)));
MXC = zeros(num_radial, r);
MYC = zeros(num_radial, r);
MY = zeros(num_radial, r, nc);
%const =  1
for i = 1: num_radial
	[myline, mycoords, outmat, XC, YC] = bresenham(IT, [x0, y0; xr(i), yr(i)], 0); 
	for canal = 1 :nc
		Iaux = S(:, :, canal);
		dim = length(XC);
		for j = 1: dim
			MXC(i, j) = YC(j);
			MYC(i, j) = XC(j);
			MY(i, j, canal)  = Iaux( YC(j), XC(j)) ;
	       		IT(XC(j), YC(j)) = const;
	       		II(XC(j), YC(j)) = const;
        	end
	end
end
imshow(II);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extrai retas radiais e as distribuicoes nas imagens reais nos canais (hh, hv, vv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% obs: cada canal produz seus proprios X, Y com dimensões diferentes!!!!
%% Mat com numero de colunas 400, para armazenar os X e Y com dim  variaveis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for canal = 1 : nc
%	for i = 1: num_radial
%		Iaux = S(:, :, canal);
		%[myline, mycoords, outmat, XC, YC] = bresenham(IT, [x0, y0; xr(i), yr(i)], 0);
		%[myline, mycoords, outmat] = bresenham(IT, [x0, y0; xr(i), yr(i)], 0);
%		dimc = r;
%		for j = 1: dimc
		%	MY(i, j, canal)  = Iaux( MXC(i, j), MYC(i, j)) ;
%       		end
%	end
%end
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
%for canal = 1: 3 
%	fname = sprintf('real_flevoland_produto_%d.txt', canal);
%	fid = fopen(fname,'w');
%	for i = 1: num_radial
%		for j = 1: r
%                fprintf(fid,'%f ', SS(i, j, canal));
%	      	end
%    		fprintf(fid,'\n');
%        end
%        fclose(fid);       
%end
%%%%%%%%%%% cuidar
%	fnamexc = sprintf('xc_flevoland.txt');
%	fnameyc = sprintf('yc_flevoland.txt');
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
cd ..
cd Code/Code_matlab
