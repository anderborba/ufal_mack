clear all;
format long;
m = 16
n = 16
MAT =zeros(m, n);
for j = 1:n
    for i = 1:m
	    MAT(i, j) =(i -1) + (j - 1);
    end
end
MAT
mm = m / 2
nn = n / 2
A = zeros(4, mm * nn);
for j = 1: nn
    for i = 1:mm
        A(:,i + (j-1) * mm) = reshape(MAT((i-1)*2+(1:2),(j-1)*2+(1:2)),4,1);
    end
end

