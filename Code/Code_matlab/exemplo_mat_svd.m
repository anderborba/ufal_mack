clear all;
format long;
m = 16
n = 16
nc= 3
MAT =zeros(m, n);
for j = 1:n
    for i = 1:m
	    MAT(i, j) = i + j;
	    %MAT(i, j) = 1.0;
    end
end
%MAT
IM(:,:,1) = MAT; 
IM(:,:,2) = MAT; 
IM(:,:,3) = MAT;
IF = fus_svd(IM, m, n, nc);
