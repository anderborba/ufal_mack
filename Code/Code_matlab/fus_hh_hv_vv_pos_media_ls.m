% Programado por AAB - versao 1.0 17/11/2018
% O programa le arquivos com evidencias de bordas para diferentes canais no diretortio ~/Data e faz a fusão das evidencias para os diferentes canais, realiza o método dos quadrados minimo depis da fusao e imprime as imagem dos canais bem como da fusao e do resultado do metodo de quadrados minimos. Diretorio de impressão /Text/Dissertacao/figuras
% Obs (1) Na linguagem r o arquivo gravado leva o nome da base de dados na primeira linha dos arquivos, verificar se já foi retirado a linha com os nomes das bases de dados, senão vai dar erro na leitura.
%     (2) Mudar os nomes dos arquivos de entrada e saida mudando as amostras.
%     (3) Escrita em arquivo comentada para evitar mudanças nas figuras.
clear all;
format long;
m = 400;
n = 400;
% leitura do arquivos de evidencias de bordas no diretorio ~/Data
% dados baseados nas referencias \cite{nhfc} e \cite{gamf}
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_nhfc.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_nhfc.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_nhfc.txt');
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_gamf.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_gamf.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_gamf.txt');
ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_vert.txt');
ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_vert.txt');
ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_vert.txt');
% vetor x para todos os metodos de quadrados minimos
for i = 1: m
	x(i) = i;
end
% media de evidencias em cada canal (não é pixel a pixel)
soma = (ev_hh(:, 3) + ev_hv(:, 3) + ev_vv(:, 3)) / 3;
y = soma';
p = polyfit(x, y, 1);
p = polyval(p, x);
% Plot
%plot(x, p, x, soma, '.')
im    = zeros(m, n) + 255;
im_hh = zeros(m, n) + 255;
im_hv = zeros(m, n) + 255;
im_vv = zeros(m, n) + 255;
im_ls = zeros(m, n) + 255;
for(i = 1: m)
	im_hh(i, round(ev_hh(i, 3))) = 0;
	im_hv(i, round(ev_hv(i, 3))) = 0;
	im_vv(i, round(ev_vv(i, 3))) = 0;
	im   (i, round(soma(i)    )) = 0;
	im_ls(i, round(soma(i)    )) = 0;
	im_ls(i, round(   p(i)    )) = 0;
end
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
errop = abs(p - 200);
max(errop)
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

