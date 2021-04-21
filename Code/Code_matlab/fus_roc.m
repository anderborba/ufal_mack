function [F] = fus_roc(E, m, n, nc)
V(1: m, 1: n)  = 0.0;
M(1: m, 1: n, 1: nc) = 0.0;
for i = 1: nc
	V(:, :) = V(:, :) + E(:, :, i);
end
for i= 1: m
	for j= 1: n
		if( V(i,j) >= 1 & V(i, j) <= nc)
			M(i, j, 1) = 1;
		end
		if( V(i,j) >= 2 & V(i, j) <= nc)
	        	M(i, j, 2) = 1;
		end
		if( V(i,j) >= 3 & V(i, j) <= nc)
			M(i, j, 3) = 1;
		end
	%	if( V(i,j) >= 4 & V(i, j) <= nc)
	%		M(i, j, 4) = 1;
	%	end
	%	if( V(i,j) >= 5 & V(i, j) <= nc)
	%		M(i, j, 5) = 1;
	%	end
	%	if( V(i, j) == nc )
	%		M(i, j, 6) = 1;
	%	end
	end
end
dim = m * n * nc;
%   Tp1 com M1E
for l  = 1: nc
	soma(1: nc) = 0.0;
	for k  = 1: nc
		for i= 1: m
			for j= 1: n
				if( M(i, j, l) > 0 & E(i, j, k) > 0 )
					soma(k) = soma(k) + 1;
				end
			end
		end
	end
	tp(l) = sum(soma)/ dim;
end
%   Fp1 com M1E
for l  = 1: nc
	soma(1: nc) = 0.0;
	for k  = 1: nc
		for i= 1: m
			for j= 1: n
				if( M(i, j, l) > 0 & E(i, j, k) == 0 )
					soma(k) = soma(k) + 1;
				end
			end
		end
	end
	fp(l) = sum(soma)/ dim;
end
%   TN1 com M1NE
for l  = 1: nc
	soma(1: nc) = 0.0;
	for k  = 1: nc
		for i= 1: m
			for j= 1: n
				if( M(i, j, l) == 0 & E(i, j, k) == 0 )
					soma(k) = soma(k) + 1;
				end
			end
		end
	end
	tn(l) = sum(soma)/ dim;
end
%   FN1 com M1NE
for l  = 1: nc
	soma(1: nc) = 0.0;
	for k  = 1: nc
		for i= 1: m
			for j= 1: n
				if( M(i, j, l) == 0 & E(i, j, k) > 0 )
					soma(k) = soma(k) + 1;
				end
			end
		end
	end
	fn(l) = sum(soma)/ dim;
end
for i = 1: nc
	tprj(i) =       tp(i) / (tp(i) + fn(i));
	fprj(i) = 1 -   (tn(i) / (fp(i) + tn(i)));
        % tp + fn tem que ser igal para todos os canais
	p(i)    = tp(i) + fn(i);
	q(i)    = tp(i) + fp(i);
	%
	a = 1 - p(i);
       	b = p(i);
       	c = -p(i);
       	x0 = fprj(i); 
       	y0 = tprj(i); 
       	%AAB: norma 2 pode ser substituido por srqt(a**2+b**2) 
        d(i) = abs(a*x0 + b*y0 + c) / sqrt(a^2 + b^2);
end
%d
%[yy,kk] = min(d)
%yy
%kk
% grafico ROC
%paux = p(1);
%display('Valor do ponto (P,P) para a contruir a reta  diagnóstico no gráfico (ROC)');
%p
%q
%x =[0: paux/100: paux];
%y = ((paux - 1)/paux) * x + 1;
%plot(fprj, tprj, 'r*', x, y, 'b-');
%%%%%%%%%%%%%%%%%% Calculo do indice kappa %%%%%%%%%%%%
%r = 0.5;
%rlin = (1 - r);
%for i = 1: nc
%	se(i)    = tprj(i);
%	sp(i)    = tn(i) / (fp(i) + tn(i));
%	pj(i)    = p(i);
%	pjlin(i) = 1 - pj(i);
%	qj(i)    = q(i);
%	qjlin(i) = 1 - qj(i);
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for i = 1: nc
%	k1(i) = (se(i) - qj(i)) / qjlin(i);
%	k0(i) = (sp(i) - qjlin(i)) / qj(i);  
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for i = 1: nc
%	kaux1 = r    * pj(i)    * qjlin(i) * k1(i);
%	kaux2 = rlin * pjlin(i) * qj(i)    * k0(i);
%	kaux3 = r    * pj(i)    * qjlin(i);
%	kaux4 = rlin * pjlin(i) * qj(i);
%	kr(i) = (kaux1 + kaux2) / (kaux3 + kaux4);
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Ideia geométrica para kappa %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%v(1) = k0(1);
%v(2) = kr(1);
%u(1) = k1(1);
%u(2) = kr(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%kk0(1) = 0;
%kk1(1) = 0;
%kk0(2) = 1;
%kk1(2) = 1;
%%%%%%%%%%%%%%%%%%%% Funcao identidade %%%%%%%%%%%%%
%nid = 100;
%xid =[0: 1/nid: 1];
%yid = xid;
%%%%%%%%%%%%%%% Inclinação e linha projeção r %%%%
%for i = 1: nc
%	s(i) = - (pjlin(i) * qj(i) * rlin ) / (pj(i) * qjlin(i) * r);
%end
%yplin1 = s(1) * xid + 1;
%yplin2 = s(2) * xid + 1;
%yplin3 = s(3) * xid + 1;
%yplin2 = s(2) * xid + 1;
%yplin3 = s(3) * xid + 1;
%plot(xid, yid, 'y-', xid, yplin1, 'b-', xid, yplin2, 'g-', xid, yplin3, 'r-');
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
F = M(:,:, 2);
