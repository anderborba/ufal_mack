function [B,d] = cwishart_variates(cm,looks,Nsamples);
%function out = cwishart_variates(cm,looks,N);
%
% Gives a (p x p x Nsamples) matrix of complex Wishart variates
% with a covariance matrix CM and equivalent number of looks L.
% Often defined as having L - p degrees of freedom.
%
% CM should be positive definite hermitian (see www.mathworld.com)
%
% Note that the determinant (det) of a single look variate
% should equal 0, and that the det of an arbitrary look variate
% should be positive. However... for low looks the det is often
% complex or negative -  I'm not sure if this is due to floating
% point representation or a mistake in this method. Furthermore
% the output matrix is often not _exactly_ hermitian, again
% this is due to floating point I think...
%
% Source: Brute force evaluation.
% The method by Odell, P.L. and Feiveson, A.H. (1996)
% "A numerical procedure to generate a sample covariance matrix"
% Journal of the AMS 61, pp 199-203 may speed this up but I 
% couldn't get it to work with complex numbers....
%
% Assumes lower triangular part of cm is conjugate of upper
%
% Part of the Matlab Radar Toolbox v0.11 by Glen Davidson at www.radarworks.com
% Please acknowledge use of this toolbox in any publication or software.
% This header must be retained in any derivative work

%warning('This function is doubtful, see help')

if (prod(size(Nsamples)) ~= 1)
  error('Scalar N please')
end
if (ndims(cm) > 2)
  error('CM is Covariance matrix or scalar coefficient')
end
if (size(cm,1) == size(cm,2)) %check square matrix
  span = size(cm,1);
else
  error('Square cov matrix')
end
if span < 2
  error('Need a multi-variate covariance matrix')
end
if looks < 1
  error('Need more than 1 look')
end
  
n = span;
P = ctranspose(chol(cm));

B = zeros(n,n,Nsamples);
d = zeros(1,Nsamples);


%form large matrix of complex-normal variates
randvals = (randn(n,looks,Nsamples) + j*randn(n,looks,Nsamples) ) / sqrt(2);

% If you're using Matlab R13 (version 6.5) or greater, loops are much faster but
% if not then enhanced matrix multiplication (Peter Boettcher @ MIT)
% is very useful for a large number of samples e.g. 10^6;
%
% This is a mex file, but due to an interface with BLAS Fortran it can currently
% only handle real inputs (as of Version 1.8);
% just expand as:
% A * B = real(A)*real(B)-imag(A)*imag(B) + j*imag(A)*real(B) +j*real(A)*imag(B)
%test for linux, windows and solaris mex file
if exist('ndfun')
  disp('Using Fast NDFUN method')
  W = ndfun('mult',real(P),real(randvals)) - ndfun('mult',imag(P),imag(randvals)) + ...
      j*( ndfun('mult',real(P),imag(randvals)) + ndfun('mult',imag(P),real(randvals)) );
  cW = conj(permute(W,[2,1,3]));
  B = ndfun('mult',real(W),real(cW)) - ndfun('mult',imag(W),imag(cW)) + ...
      j*( ndfun('mult',real(W),imag(cW)) + ndfun('mult',imag(W),real(cW)) );
  B = B / looks;
else %2 times slower in Matlab 6.5 , worse in older version
  for sloop = 1:Nsamples
    W = randvals(:,:,sloop);
    W = P*W;
    W = W * ctranspose(W);
    B(:,:,sloop) = W / looks;
  end
end

%correct complex diagonals being O(1 + eps*j) due to floating point errors
for cloop = 1:n
  B(cloop,cloop,:) = abs(B(cloop,cloop,:));
end
