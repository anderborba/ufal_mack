clear all;
format long;
m = 400;
n = 400;
ev_hh = load('evidencias_hh.txt');
ev_hv = load('evidencias_hv.txt');
ev_vv = load('evidencias_vv.txt');
% vetor c para todos os metodos de quadrados minimos
for i = 1: m
	x(i) = i;
end
% Quadrados mínimos no canal I_hh
p_hh = ev_hh(:, 3);
p_hh = polyfit(x, p_hh', 1);
p_hh = polyval(p_hh, x);
% Quadrados mínimos no canal I_hv
p_hv = ev_hv(:, 3);
p_hv = polyfit(x, p_hv', 1);
p_hv = polyval(p_hv, x);
% Quadrados mínimos no canal I_hv
p_vv = ev_vv(:, 3);
p_vv = polyfit(x, p_vv', 1);
p_vv = polyval(p_vv, x);
% Quadrados mínimos na fusão dos tres canais depois do quadrados minimos
p_soma = (p_hh + p_hv + p_vv) / 3;
p_f = p_soma;
p_f = polyfit(x, p_f, 1);
p_f = polyval(p_f, x);
% Plot pixel X evidencia de borda
%plot(x, p_f, x, p_soma, '.')
% Quadrados mínimos depois da fusão com media
soma = (ev_hh(:, 3) + ev_hv(:, 3) + ev_vv(:, 3)) / 3;
% Least - Square
y = soma';
p = polyfit(x, y, 1);
p = polyval(p, x);
% Plot
%plot(x, p, x, soma, '.')
im = zeros(m, n) + 255;
for(i = 1: m)
	im(i, round(soma(i))) = 0;
	im(i, round(   p(i))) = 0;
	pround(i) = round(p(i));
	%pround_f(i) = round(p_f(i));
end
imshow(im)
%fname = sprintf('evidencias_ls.txt');
%fid = fopen(fname, 'w');
%for (i = 1: m)
%	fprintf(fid, '%f', p(i));
%	fprintf(fid, '\n');
%end
%fclose(fid);
errop = abs(p - 200);
max(errop)
%fname_errop = sprintf('fusao_ls_erro.txt');
%fid_errop = fopen(fname_errop, 'w');
%for (i = 1: m)
%	fprintf(fid_errop, '%f', errop(i));
%	fprintf(fid_errop, '\n');
%end
%fclose(fid_errop);

