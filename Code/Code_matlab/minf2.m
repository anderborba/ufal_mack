function[MI] = minf2(im1,im2)
%%% MUTUALINFORMATION: compute the mutual information between two images
%%%   mutualinformation( im1, im2 )
%%%     im1: grayscale or color image, or 1-D signal
%%%     im2: must be same size as im1

	bins = [0:8:255]
	N    = length(bins)

	%%% JOINT HISTOGRAM
	joint  = zeros( N, N );
	X1     = im1(:);
	X2     = im2(:);
	maxval = max( [X1 ; X2] )
	X1     = round( X1 * (N-1)/maxval ) + 1
	X2     = round( X2 * (N-1)/maxval ) + 1
	for k = 1 : length(X1)
		 joint( X1(k), X2(k) ) = joint( X1(k), X2(k) ) + 1;
	end
	joint = joint / sum(joint(:))

	%%% MARGINALS
	NX2 = sum(joint );
	NX1 = sum(joint');

	%%% MUTUAL INFORMATION
	MI = 0;
	for i = 1 : N
		 for j = 1 : N
				if( joint(i,j)>eps & NX1(i)>eps & NX2(j)> eps )
					 MI = MI + joint(i,j) * log( joint(i,j)/(NX1(i)*NX2(j)) );
				end
		 end
	end
