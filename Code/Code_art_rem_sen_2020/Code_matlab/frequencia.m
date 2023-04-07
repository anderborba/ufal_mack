function [freq] = frequencia(erro, k, num_radial)
contador = 0;
for j = 1: num_radial
  if (erro(j) < k)
    contador = contador + 1;
  end
end
freq = contador / num_radial;
