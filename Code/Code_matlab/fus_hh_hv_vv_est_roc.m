% Programado por AAB - versao 1.0 **/**/20**
% O programa le arquivos com evidencias de bordas para diferentes canais no diretortio ~/Data e faz a fusão das evidencias para os diferentes canais, com o método estatístico usando a curva ROC. Diretorio de impressão /Text/Dissertacao/figurasi
% Obs (1) Na linguagem r o arquivo gravado leva o nome da base de dados na primeira linha dos arquivos, verificar se já foi retirado a linha com os nomes das bases de dados, senão vai dar erro na leitura.
%     (2) Mudar os nomes dos arquivos de entrada e saida mudando as amostras.
%     (3) Escrita em arquivo comentada para evitar mudanças nas figuras.
clear all;
format long;
m = 400;
n = 400;
nc = 3; % número de canais considerado
% leitura do arquivos de evidencias de bordas no diretorio ~/Data
% dados baseados nas referencias \cite{nhfc} e \cite{gamf}
ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_nhfc.txt');
ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_nhfc.txt');
ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_nhfc.txt');
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_gamf.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_gamf.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_gamf.txt');
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_vert.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_vert.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_vert.txt');
% vetor x para todos os metodos de quadrados minimos
%for i = 1: m
%	x(i) = i;
%end
% media de evidencias em cada canal (não é pixel a pixel)
%soma = (ev_hh(:, 3) + ev_hv(:, 3) + ev_vv(:, 3)) / 3;
% Plot
%plot(x, p, x, soma, '.')
%for i = 1: nc
%	ct(i) = randi([1, 5]);
%end
%
ev_1 = ev_hh(:, 3);
ev_2 = ev_hv(:, 3);
ev_3 = ev_vv(:, 3);
%
%tev_1 = ev_1;
%tev_1((ev_1 < 200 - ct(1)) | (ev_1 > 200 + ct(1))) = 0;
%tev_2 = ev_2;
%tev_2((ev_2 < 200 - ct(2)) | (ev_2 > 200 + ct(2))) = 0;
%tev_3 = ev_3;
%tev_3((ev_3 < 200 - ct(3)) | (ev_3 > 200 + ct(3))) = 0;
%
%
E1 = zeros(m, n);
E2 = zeros(m, n);
E3 = zeros(m, n);
M1 = zeros(m, n);
M2 = zeros(m, n);
M3 = zeros(m, n);
for(i = 1: m)
	E1(i, round(ev_hh(i, 3)))      = 1;
	E2(i, round(ev_hv(i, 3)))      = 1;
	E3(i, round(ev_vv(i, 3)))      = 1;
%	if (tev_1(i) > 0)
%		M1(i, round(tev_1(i)))    = 1;
%	end
%	if (tev_2(i) > 0)
%		M2(i, round(tev_2(i)))    = 1;
%	end
%	if (tev_3(i) > 0)
%		M3(i, round(tev_3(i)))    = 1;
%	end
end
V = E1 + E2 + E3;
for i= 1: m
	for j= 1: n
		if( V(i, j) ==  1 )
			M1(i, j) = 1;
		end
		if( V(i,j) >= 1 & V(i, j) <= 2)
	        	M2(i, j) = 1;
		end
		if( V(i,j) >= 1 & V(i, j) <= 3)
			M3(i, j) = 1;
		end
	end
end
dim = m * n * nc;
% Endereço das bordas de Mi, i=1,..., nc %%%%%%
%[m1rows, m1cols, m1vals] = find(M1);
%[m2rows, m2cols, m2vals] = find(M2);
%[m3rows, m3cols, m3vals] = find(M3);
% Endereço das bordas de Ei, i=1,   , nc %%%%%%
%[e1rows, e1cols, e1vals] = find(E1);
%[e2rows, e2cols, e2vals] = find(E2);
%[e3rows, e3cols, e3vals] = find(E3);
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
% grafico ROC
p = max(tp + fn);
x =[0:p/100:p];
y = ((p -1)/p) * x + 1;
%y = x;
plot(fp, tp, 'r*', x, y, 'b-');
%cd ..
%cd ..
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

