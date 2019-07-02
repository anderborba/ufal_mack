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
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_1.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_2.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_flor_25_155_5_3.txt');
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_gamf.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_gamf.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_gamf.txt');
%ev_hh = load('/home/aborba/git_ufal_mack/Data/evidencias_hh_vert.txt');
%ev_hv = load('/home/aborba/git_ufal_mack/Data/evidencias_hv_vert.txt');
%ev_vv = load('/home/aborba/git_ufal_mack/Data/evidencias_vv_vert.txt');
%
ev_1 = ev_hh(:, 3);
ev_2 = ev_hv(:, 3);
ev_3 = ev_vv(:, 3);
%
%
E1 = zeros(m, n);
E2 = zeros(m, n);
E3 = zeros(m, n);
for(i = 1: m)
	E1(i, round(ev_hh(i, 3)))      = 1;
	E2(i, round(ev_hv(i, 3)))      = 1;
	E3(i, round(ev_vv(i, 3)))      = 1;
end
COVAR =[reshape(E1, n * n, 1),reshape(E2, n * n, 1),reshape(E3, n * n, 1)];
C = cov(COVAR);
[V, D] = eig(C);
[SV, SD] = svd(C);
if D(1,1) >= D(2,2) 
  pca = V(:,1)./sum(V(:,1));
elseif (D(2,2) >= D(3,3))
  pca = V(:,2)./sum(V(:,2));
else
  pca = V(:,3)./sum(V(:,3));
end
%
p1 = V(:,1)./sum(V(:,1));
p2 = V(:,2)./sum(V(:,2));
p3 = V(:,3)./sum(V(:,3));
%
imf = pca(1) * E1 + pca(2) * E2 + pca(3) * E3;
imf1 = p1(1) * E1 + p1(2) * E2 + p1(3) * E3;
imf2 = p2(1) * E1 + p2(2) * E2 + p2(3) * E3;
imf3 = p3(1) * E1 + p3(2) * E2 + p3(3) * E3;
%
%%%%%% Fusao E1 - E3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%C_hh_vv = cov([E1(:) E3(:)]);
%[V_hh_vv, D_hh_vv] = eig(C_hh_vv);
%if D_hh_vv(1,1) >= D_hh_vv(2,2)
%  pca_hh_vv = V_hh_vv(:,1)./sum(V_hh_vv(:,1));
%else  
%  pca_hh_vv = V_hh_vv(:,2)./sum(V_hh_vv(:,2));
%end
%imf_hh_vv = pca_hh_vv(1) * E1 + pca_hh_vv(2) * E3;
%%%%%% Fusao E1 - E2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%C_hh_hv = cov([E1(:) E2(:)]);
%[V_hh_hv, D_hh_hv] = eig(C_hh_hv);
%if D_hh_hv(1,1) >= D_hh_hv(2,2)
%  pca_hh_hv = V_hh_hv(:,1)./sum(V_hh_hv(:,1));
%else  
%  pca_hh_hv = V_hh_hv(:,2)./sum(V_hh_hv(:,2));
%end
%imf_hh_hv = pca_hh_hv(1) * E1 + pca_hh_hv(2) * E2;
%%%%%%% Fusao E3 - E2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%C_vv_hv = cov([E3(:) E2(:)]);
%[V_vv_hv, D_vv_hv] = eig(C_vv_hv);
%if D_vv_hv(1,1) >= D_vv_hv(2,2)
%  pca_vv_hv = V_vv_hv(:,1)./sum(V_vv_hv(:,1));
%else  
%  pca_vv_hv = V_vv_hv(:,2)./sum(V_vv_hv(:,2));
%end
%imf_vv_hv = pca_vv_hv(1) * E3 + pca_vv_hv(2) * E2;


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

