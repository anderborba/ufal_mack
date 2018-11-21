%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script works with the main script:
% Polsar_two_classes_phantom_Convex_sum.m
% Used to get results in the publication:
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script has 2 matrices (PolSAR Wishart data), taken from actual
% fully PolSAR data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAB - modificado em 16/11/2018
% AAB - Sigmas provenientes das referencias \cite{nhfc} e \cite{gamf}
format long
% AAB sigmas da referencia \cite{nhfc}
% Class: 
S(:,:,1)= [ 
 962892            19171 - 3579i       -154638+191388i
 19171  + 3579i    56707                -5798 + 16812i
-154638 - 191388i -5798 - 16812i        472251        ];
% Class:
S(:,:,2) = [ 
 360932              11050 + 3759i  63896 + 1581i
 11050 - 3759i       98960           6593 + 6868i
 63896 - 1581i       6593  - 6868i   208843];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAB sigmas da referencia \cite{gamf}
% Class: 
%S(:,:,2)= [ 
%0.042811  0.000072+-0.003180i 0.010435+0.005022i
%0.000072+0.003180i 0.035977 0.000784+0.004886i
%0.010435+-0.005022i 0.000784+-0.004886i 0.066498];

% Class:
%S(:,:,2) = [ 
%0.014380  0.001333+-0.000076i -0.000755+0.001570i
%0.001333+0.000076i 0.002789 -0.001044+0.001101i
%-0.000755+-0.001570i -0.001044+-0.001101i 0.015387];



% Number of looks (user may modify this data, but L >= 3)
L = 4;
% Save data to .mat format to be loade by the main script
save S_2_classes.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
