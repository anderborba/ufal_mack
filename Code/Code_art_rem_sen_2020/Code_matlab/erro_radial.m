function [erro] = erro_radial(xc, yc, GT, IM, r, j)
cont    = 0;
erro_gt = 0;
for i = 1: r
  if (yc(j, i) && xc(j, i)) > 0
    if  GT(yc(j, i), xc(j, i)) > 0
		  erro_gt = sqrt(yc(j, i)^2 + xc(j, i)^2);
    end
		if  IM(yc(j, i), xc(j, i)) > 0
		  cont = cont + 1;
		  erro_aux(cont) = sqrt(yc(j, i)^2 + xc(j, i)^2);
		end
  end
	minimo = 100;
  for c=1: cont
    d = abs(erro_aux(c) - erro_gt);
		minimo = min(d, minimo);
	end
end
erro= minimo;
