%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script generates PolSAR phantom with 2 classes and run Monte Carlo 
% experiments.
% Used to get results in the publication:
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program generates the phantom in this sense:
% Class 1 = S1
% Class 2 = alpha * S1 + (1-alpha)*S1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Format of S (classes Matrix): see S_6_classes.m for a 
% comprenhension of the format of data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We get a  number of phantoms depending of the alpha increment.
% Then, as this process is not symmetric, we repeat as
% Class 1 = alpha * S1 + (1-alpha)*S1
% Class 2 = S1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This scripts requires the following Matlab scripts (in the same folder):
%   - cwishart_variates().m (from  Glen Davidson): it simulates a Wishart
%   variable,
%   - Generate_PolSAR_two_classes_phantom(): to generate each phantom for each
%   Monte Carlo simulation.
%   - a valid S_6_classes.mat data: it may be generated from the provided
%   example S_6_classes.m (run this script). You may add your own
%   PolSAR representative for classes.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% How to use this script?:
% 
% The results are saved to the folder \results, that it must exist just
% branching from the folder where these scripts are located at. For
% instance:
% 
%  .\my_folder   (all the .m scripts are in this folder)
%  .\my_folder\results  (user must create the folder "results")
% 
% 1. Run the S_6_classes.m script to generate the S_6_classes.mat
% file that contains the Wishart representative of 6 clasees taken from
% actual fully PolSAR data. From each representative, a set of random
% samples is generated automatically for each combination of classes and
% each value of the alpha parameter (ranging from 0:increment_alpha:1.
% 
% 2. Select the increment for parameter alpha, d_alpha to generate as many
% phantoms as desired. For instance, to generate 10 phantoms, select
% d_alpha = 0.1.
% 
% 3. Select the pair of classes to combine by means of a convex sum (see
% the publication mentioned above, for a better understanding of this
% process). For instance, to generate a phantom with classes 2 and 3
% (referred to the file S_6_classes.m), make in this script:
% 
% S1 = S(:,:,3);
% S2 = S(:,:,2);
% clase_1 = 1;
% clase_2 = 2;
% 
% Output: 
% The output of this script is the collection of 9 matrices for each
% d_alpha value. The format of this data is as follows:
% 
% Phantom_%2.3f_%d_%d_%d.txt',alpha,clase_1,clase_2,j);
% with j =1 : 9.
% So, for the selection, 
%     S1 = S(:,:,3);
%     S2 = S(:,:,2);
%     clase_1 = 3;
%     clase_2 = 2;
% and for a variable at this moment, alpha = 0.8,
% the file saved 
%               Phantom_0.8_1_2_1.txt --> Ihh--> (I(11))  (real)
%               Phantom_0.8_1_2_2.txt --> Ihv--> (I(22))  (real)
%               Phantom_0.8_1_2_3.txt --> Ivv--> (I(33))  (real)
%               Phantom_0.8_1_2_4.txt --> I12--> (real component)
%               Phantom_0.8_1_2_5.txt --> I12--> (complex component)
%               Phantom_0.8_1_2_6.txt --> I13--> (real component)
%               Phantom_0.8_1_2_7.txt --> I13--> (complex component)
%               Phantom_0.8_1_2_8.txt --> I23--> (real component)
%               Phantom_0.8_1_2_9.txt --> I23--> (complex component)
% 
% 
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc         % clean screen
clear       % clear workspace
close all   % close all open plots
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% alpha increment: alpha = 1: d_alpha : 1
d_alpha = 0.1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geometry of the phantom: do not change these values.
Height= 400
Width = 400
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load representative of each class: 
load S_2_classes.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experiments; combine two classes
S1 = S(:,:,1);
S2 = S(:,:,2);
clase_1 = 1;
clase_2 = 2;
% User may combines {1,2}, {1,3}...{1,6},...{5,6},
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic                         % to measure computational cost
for alpha = 0: d_alpha: 0
    alpha = 0.0; % print the value on screen 
Height
Width
    [phantom(:,:,:)] =  Generate_PolSAR_two_classes_phantom(S,L,Height, Width);
Height
Width

    % geração de canais interferometricos
    %for i = 1: Height
       	%for j = 1: Width
	%     	SS(i, j, 1)  = sqrt(phantom(i, j, 4)^2 + phantom(i, j, 5)^2);
     	%	SS(i, j, 2)  = sqrt(phantom(i, j, 6)^2 + phantom(i, j, 7)^2);
     	%	SS(i, j, 3)  = sqrt(phantom(i, j, 8)^2 + phantom(i, j, 9)^2);
	%end
    %end
    
    % Activate to visualize the Monte Carlo phantom generated
    % Visualize Pauli's representation of phantom generated
    Ihh=mat2gray(real(phantom(:,:,1)));
    Ihh=imadjust(Ihh);
    Ihv=mat2gray(real(phantom(:,:,2)));
    Ihv=imadjust(Ihv);
    Ivv=mat2gray(real(phantom(:,:,3)));
    Ivv=imadjust(Ivv);
   
    %imshow(IMG)
    II=cat(3,abs(Ihh + Ivv), abs(Ihv), abs(Ihh - Ivv));
    escala=mean2(II)*3;figure(1),imshow(imresize(II,1),[0,escala]);
    
    % Save to file in plain format (it may be loaded directly by C, C++, R
    % code or Matlab (see below how to load a .txt file).
    % save data to .txt 
    %the 9 matrices
    % AAB - renomear arquivo de saida para diferentes sigmas
    cd result_gamf
%      % plain format
    for j = 1: 9
        fname = sprintf('Phantom_gamf_%2.3f_%d_%d_%d.txt',alpha,clase_1,clase_2,j);
        fid = fopen(fname,'w');
%        fprintf(fid,'%d %d\r\n', Height, Width);
        for ii = 1: Height
            for jj = 1: Width
                fprintf(fid,'%f ',phantom(ii,jj,j));
            end
            fprintf(fid,'\r\n');
        end
        fclose(fid);       
    end    
    ii = ii + 1;
    cd ..
end
%cd ..
%cd ..
%cd Data
%    for j = 1: 3
%        fname = sprintf('Phantom_nhfc_prod_%2.3f_%d_%d_%d.txt',alpha,clase_1,clase_2,j);
%        fid = fopen(fname,'w');
%        fprintf(fid,'%d %d\r\n', Height, Width);
%        for ii = 1: Height
%            for jj = 1: Width
%                fprintf(fid,'%f ', SS(ii,jj,j));
%            end
%            fprintf(fid,'\r\n');
%        end
%        fclose(fid);       
%    end
%cd ..
%cd Code/Code_matlab
toc  %stop measuring time


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To load a .txt file in Matlab (with the above saved format) and write it
% to matrix V.:
%  fid=fopen('my_file.txt','r');
%   M=fscanf(fid,'%d',1);
%   N=fscanf(fid,'%d',1);
%   for i=1:M
%    for j=1:N
%     tmp=fscanf(fid,'%f',1);
%     V(i,j)=tmp;
%    end
%    fscanf(fid,'\n');
%   end
%   status=fclose(fid)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     L. Gomez, L. Alvarez, L. Mazorra and, A.C. Frery
%     "Fully PolSAR image classification using machine learning techniques and
%      reaction-difusion systems,", Neurocomputing, 2016 (under revision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Please, refer to the publication when publishing results obtained
%            with this code or variations of it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coded to Matlab by Luis Gomez, CTIM, Universidad de Las Palmas de Gran
% Canaria, January 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


