% Programado por AAB - versao 1.0 **/**/20**
% O programa le arquivos com evidencias de bordas para diferentes canais no diretortio ~/Data e faz a fusão das evidencias para os diferentes canais, com o método estatístico usando a curva ROC. Diretorio de impressão /Text/Dissertacao/figurasi
% Obs (1) Na linguagem r o arquivo gravado leva o nome da base de dados na primeira linha dos arquivos, verificar se já foi retirado a linha com os nomes das bases de dados, senão vai dar erro na leitura.
%     (2) Mudar os nomes dos arquivos de entrada e saida mudando as amostras.
%     (3) Escrita em arquivo comentada para evitar mudanças nas figuras.
clear all;
format long;
% leitura do arquivos de evidencias de bordas no diretorio ~/Data
% dados baseados nas referencias \cite{nhfc} e \cite{gamf}
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_nhfc.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_nhfc.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_nhfc.txt');
ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_1.txt');
ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_2.txt');
ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_3.txt');
%
ev_1 = ev_hh(:, 3);
ev_2 = ev_hv(:, 3);
ev_3 = ev_vv(:, 3);
%
% processando evidencias para gerar imagens de flor
N = 800;    % Tamanho da imagem N X N
m = N;
n = N;
nc = 3; % número de canais considerado
rmax = 200; % Raio maximo da flor
beta  = 25;
del   = 155;
nu    = 5;
x0 = N / 2;
y0 = N / 2;
img_hh = zeros(N); 
img_hv = zeros(N); 
img_vv = zeros(N); 
evidencias_hh = round(ev_hh);
evidencias_hv = round(ev_hv);
evidencias_vv = round(ev_vv);
num_radial = 400;
tr = linspace(0, 2 * pi, num_radial + 1);
r =  2 * del;
x = x0 + r .* cos(tr);
y = y0 + r .* sin(tr);
xr= round(x);
yr= round(y);
for i = 1: num_radial
	[myline, mycoords, outmat, XT1_hh, YT1_hh] = bresenham(img_hh, [x0, y0; xr(i), yr(i)], 0);
	[myline, mycoords, outmat, XT1_hv, YT1_hv] = bresenham(img_hv, [x0, y0; xr(i), yr(i)], 0);
	[myline, mycoords, outmat, XT1_vv, YT1_vv] = bresenham(img_vv, [x0, y0; xr(i), yr(i)], 0);
	img_hh(XT1_hh(evidencias_hh(i, 3)), YT1_hh(evidencias_hh(i, 3))) = 1;
	img_hv(XT1_hv(evidencias_hv(i, 3)), YT1_hv(evidencias_hv(i, 3))) = 1;
	img_vv(XT1_vv(evidencias_vv(i, 3)), YT1_vv(evidencias_vv(i, 3))) = 1;
end
%img_hh = 1 - img_hh;
%img_hv = 1 - img_hv;
%img_vv = 1 - img_vv;
%
E1 = zeros(m, n);
E2 = zeros(m, n);
E3 = zeros(m, n);
M1 = zeros(m, n);
M2 = zeros(m, n);
M3 = zeros(m, n);
E1 = img_hh;
E2 = img_hv;
E3 = img_vv;
V = E1 + E2 + E3;
% aplicacao dos limiares
for i= 1: m
	for j= 1: n
		if( V(i,j) >= 1 & V(i, j) <= 3)
			M1(i, j) = 1;
		end
		if( V(i,j) >= 2 & V(i, j) <= 3)
	        	M2(i, j) = 1;
		end
		if( V(i, j) == 3 )
			M3(i, j) = 1;
		end
	end
end
dim = m * n * nc;
%   Tp1 com M1E
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M1(i, j) > 0 & E1(i, j) > 0 )
			somae1 = somae1 + 1;
		end
		if( M1(i, j) > 0 & E2(i, j) > 0)
			somae2 = somae2 + 1;
		end
		if( M1(i, j) > 0 & E3(i, j) > 0)
			somae3 = somae3 + 1;
		end
	end
end
tp(1) = (somae1 + somae2 + somae3)/ dim;
%   Tp2 com M2E
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M2(i, j) > 0 & E1(i, j) > 0 )
			somae1 = somae1 + 1;
		end
		if( M2(i, j) > 0 & E2(i, j) > 0)
			somae2 = somae2 + 1;
		end
		if( M2(i, j) > 0 & E3(i, j) > 0)
			somae3 = somae3 + 1;
		end
	end
end
tp(2) = (somae1 + somae2 + somae3)/ dim;
%   Tp3 com M3E
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M3(i, j) > 0 & E1(i, j) > 0 )
			somae1 = somae1 + 1;
		end
		if( M3(i, j) > 0 & E2(i, j) > 0)
			somae2 = somae2 + 1;
		end
		if( M3(i, j) > 0 & E3(i, j) > 0)
			somae3 = somae3 + 1;
		end
	end
end
tp(3) = (somae1 + somae2 + somae3)/ dim;
%   Fp1 com M1E
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M1(i, j) > 0 & E1(i, j) == 0 )
			somae1 = somae1 + 1;
		end
		if( M1(i, j) > 0 & E2(i, j) == 0)
			somae2 = somae2 + 1;
		end
		if( M1(i, j) > 0 & E3(i, j) == 0)
			somae3 = somae3 + 1;
		end
	end
end
fp(1) = (somae1 + somae2 + somae3)/ dim;
%   fp2 com M2E
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M2(i, j) > 0 & E1(i, j) == 0 )
			somae1 = somae1 + 1;
		end
		if( M2(i, j) > 0 & E2(i, j) == 0)
			somae2 = somae2 + 1;
		end
		if( M2(i, j) > 0 & E3(i, j) == 0)
			somae3 = somae3 + 1;
		end
	end
end
fp(2) = (somae1 + somae2 + somae3)/ dim;
%   fp3 com M3E
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M3(i, j) > 0 & E1(i, j) == 0 )
			somae1 = somae1 + 1;
		end
		if( M3(i, j) > 0 & E2(i, j) == 0)
			somae2 = somae2 + 1;
		end
		if( M3(i, j) > 0 & E3(i, j) == 0)
			somae3 = somae3 + 1;
		end
	end
end
fp(3) = (somae1 + somae2 + somae3)/ dim;
%   TN1 com M1NE
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M1(i, j) == 0 & E1(i, j) == 0 )
			somae1 = somae1 + 1;
		end
		if( M1(i, j) == 0 & E2(i, j) == 0)
			somae2 = somae2 + 1;
		end
		if( M1(i, j) == 0 & E3(i, j) == 0)
			somae3 = somae3 + 1;
		end
	end
end
tn(1) = (somae1 + somae2 + somae3)/ dim;
%   TN2 com M2NE
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M2(i, j) == 0 & E1(i, j) == 0 )
			somae1 = somae1 + 1;
		end
		if( M2(i, j) == 0 & E2(i, j) == 0)
			somae2 = somae2 + 1;
		end
		if( M2(i, j) == 0 & E3(i, j) == 0)
			somae3 = somae3 + 1;
		end
	end
end
tn(2) = (somae1 + somae2 + somae3)/ dim;
%   TN3 com M3NE
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M3(i, j) == 0 & E1(i, j) == 0 )
			somae1 = somae1 + 1;
		end
		if( M3(i, j) == 0 & E2(i, j) == 0)
			somae2 = somae2 + 1;
		end
		if( M3(i, j) == 0 & E3(i, j) == 0)
			somae3 = somae3 + 1;
		end
	end
end
tn(3) = (somae1 + somae2 + somae3)/ dim;
%   FN1 com M1NE
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M1(i, j) == 0 & E1(i, j) > 0 )
			somae1 = somae1 + 1;
		end
		if( M1(i, j) == 0 & E2(i, j) > 0)
			somae2 = somae2 + 1;
		end
		if( M1(i, j) == 0 & E3(i, j) > 0)
			somae3 = somae3 + 1;
		end
	end
end
fn(1) = (somae1 + somae2 + somae3)/ dim;
%   TN2 com M2NE
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M2(i, j) == 0 & E1(i, j) > 0 )
			somae1 = somae1 + 1;
		end
		if( M2(i, j) == 0 & E2(i, j) > 0)
			somae2 = somae2 + 1;
		end
		if( M2(i, j) == 0 & E3(i, j) > 0)
			somae3 = somae3 + 1;
		end
	end
end
fn(2) = (somae1 + somae2 + somae3)/ dim;
%   TN3 com M3NE
somae1 = 0;
somae2 = 0;
somae3 = 0;
for i= 1: m
	for j= 1: n
		if( M3(i, j) == 0 & E1(i, j) > 0 )
			somae1 = somae1 + 1;
		end
		if( M3(i, j) == 0 & E2(i, j) > 0)
			somae2 = somae2 + 1;
		end
		if( M3(i, j) == 0 & E3(i, j) > 0)
			somae3 = somae3 + 1;
		end
	end
end
fn(3) = (somae1 + somae2 + somae3)/ dim;

for i = 1: nc
	tprj(i) =       tp(i) / (tp(i) + fn(i));
	fprj(i) = 1 -   (tn(i) / (fp(i) + tn(i)));
	p(i)    = tp(i) + fn(i);
	q(i)    = tp(i) + fp(i);
end	
% grafico ROC
paux = p(1);
display('Valor do ponto (P,P) para a contruir a reta  diagnóstico no gráfico (ROC)');
p
x =[0: paux/100: paux];
y = ((paux - 1)/paux) * x + 1;
%y = x;
%fprj(2)=0;
%tprj(2)=0;
%plot(fprj, tprj, 'r*', x, y, 'b-');
%%%%%%%%%%%%%%%%%% Calculo do indice kappa %%%%%%%%%%%%
r = 0.5;
rlin = (1 - r);
for i = 1: nc
	se(i)    = tprj(i);
	sp(i)    = tn(i) / (fp(i) + tn(i));
	pj(i)    = p(i);
	pjlin(i) = 1 - pj(i);
	qj(i)    = q(i);
	qjlin(i) = 1 - qj(i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1: nc
	k1(i) = (se(i) - qj(i)) / qjlin(i);
	k0(i) = (sp(i) - qjlin(i)) / qj(i);  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1: nc
	kaux1 = r    * pj(i)    * qjlin(i) * k1(i);
	kaux2 = rlin * pjlin(i) * qj(i)    * k0(i);
	kaux3 = r    * pj(i)    * qjlin(i);
	kaux4 = rlin * pjlin(i) * qj(i);
	kr(i) = (kaux1 + kaux2) / (kaux3 + kaux4);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Ideia geométrica para kappa %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v(1) = k0(1);
v(2) = kr(1);
u(1) = k1(1);
u(2) = kr(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kk0(1) = 0;
kk1(1) = 0;
kk0(2) = 1;
kk1(2) = 1;
%%%%%%%%%%%%%%%%%%% Funcao identidade %%%%%%%%%%%%%
nid = 100;
xid =[0: 1/nid: 1];
yid = xid;
%%%%%%%%%%%%%%% Inclinação e linha projeção r %%%%
for i = 1: nc
	s(i) = - (pjlin(i) * qj(i) * rlin ) / (pj(i) * qjlin(i) * r);
end
yplin1 = s(1) * xid + 1;
yplin2 = s(2) * xid + 1;
yplin3 = s(3) * xid + 1;
%yplin2 = s(2) * xid + 1;
%yplin3 = s(3) * xid + 1;
plot(xid, yid, 'y-', xid, yplin1, 'b-', xid, yplin2, 'g-', xid, yplin3, 'r-');
%plot(k0,k1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(v,u, 'r-', kk0, kk1, 'b-');
%cd ..
%cd ..
%cd Data
%fname = sprintf('curva_roc_3_canais.txt');
%fid = fopen(fname, 'w');
%for (i = 1: nc)
%	fprintf(fid, '%f %f', fprj(i), tprj(i));
%	fprintf(fid, '\n');
%end
%fclose(fid);
%cd ..
%cd Code/Code_matlab
%cd Text/Dissertacao/figuras
%imshow(im_hh)
%print(figure(1), '-dpdf', 'ev_hh_vert.pdf')
%imshow(im_hv)
%print(figure(1), '-dpdf', 'ev_hv_vert.pdf')
%imshow(im_vv)
%print(figure(1), '-dpdf', 'ev_vv_vert.pdf')
%imshow(im)
%print(figure(1), '-dpdf', 'fusao_soma_ev_hh_hv_vv_vert.pdf')
%imshow(im_ls)
%print(figure(1), '-dpdf', 'fusao_ls_vert.pdf')
%cd ..
%cd ..
%cd ..
%cd Code/Code_matlab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%errop = abs(p - 200);
%max(errop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cd ..
%cd ..
%cd Data
%fname = sprintf('evidencias_ls_vert.txt');
%fid = fopen(fname, 'w');
%for (i = 1: m)
%	fprintf(fid, '%f', p(i));
%	fprintf(fid, '\n');
%end
%fclose(fid);
%fname_errop = sprintf('fusao_ls_erro_vert.txt');
%fid_errop = fopen(fname_errop, 'w');
%for (i = 1: m)
%	fprintf(fid_errop, '%f', errop(i));
%	fprintf(fid_errop, '\n');
%end
%fclose(fid_errop);
%cd ..
%cd Code/Code_matlab

