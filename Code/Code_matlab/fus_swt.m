%function[] = SWTimfuse1L_demo()
% Image fusion by (one level)discrete stationary wavelet transform  - demo
% by VPS Naidu, MSDF Lab, NAL, Bangalore
% image decomposition using discrete stationary wavelet transform
function [F] = fus_swt(E, m, n, nc)
[A1,H1,V1,D1] = swt2(E(:, :, 1), 1, 'sym2');
[A2,H2,V2,D2] = swt2(E(:, :, 2), 1, 'sym2');
[A3,H3,V3,D3] = swt2(E(:, :, 3), 1, 'sym2');
[A4,H4,V4,D4] = swt2(E(:, :, 4), 1, 'sym2');
[A5,H5,V5,D5] = swt2(E(:, :, 5), 1, 'sym2');
[A6,H6,V6,D6] = swt2(E(:, :, 6), 1, 'sym2');

% fusion start ideia 2
Af   = (A1 + A2 + A3 + A4 + A5 + A6) / nc;
AUX1 = max(H1  , H2);
AUX1 = max(AUX1, H3);
AUX1 = max(AUX1, H4);
AUX1 = max(AUX1, H5);
Hf   = max(AUX1, H6);
AUX2 = max(V1  , V2);
AUX2 = max(AUX2, V3);
AUX2 = max(AUX2, V4);
AUX2 = max(AUX2, V5);
Vf   = max(AUX2, V6);
AUX3 = max(D1  , D2);
AUX3 = max(AUX3, D3);
AUX3 = max(AUX3, D4);
AUX3 = max(AUX3, D5);
Df   = max(AUX3, D6);
% fused image
F = iswt2(Af,Hf,Vf,Df,'sym2');
