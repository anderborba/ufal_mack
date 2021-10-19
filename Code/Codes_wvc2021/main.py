### Version 03/08/2021
# Article Tengarss 2019
# Ref:
# A. A. de Borba,
# M. Marengoni and
# A. C. Frery,
# "Fusion of Evidences for Edge Detection in PolSAR Images,"
# 2019 IEEE Recent Advances in Geoscience and Remote Sensing :
# Technologies, Standards and Applications (TENGARSS), 2019, pp. 80-85,
# doi: 10.1109/TENGARSS48957.2019.8976040.
#
# bibtex
# @INPROCEEDINGS{8976040,
#  author={de Borba, Anderson A. and Marengoni, Maurício and Frery, Alejandro C.},
#  booktitle={2019 IEEE Recent Advances in Geoscience and Remote Sensing : Technologies, Standards and Applications (TENGARSS)},
#  title={Fusion of Evidences for Edge Detection in PolSAR Images},
#  year={2019},
#  volume={},
#  number={},
#  pages={80-85},
#  doi={10.1109/TENGARSS48957.2019.8976040}}
#
## Import all required libraries
import numpy as np
## Used to read images in the mat format
import scipy.io as sio
## Used to equalize histograms in images
from skimage import exposure
## Used to present the images
import matplotlib as mpl
import matplotlib.pyplot as plt
## Used to find border evidences
import math
from scipy.optimize import dual_annealing
## Used in the DWT and SWT fusion methods
import pywt
#### Used to find_evidence_bfgs
from scipy.optimize import minimize
## entry parameters
import sys
## Used
### Import mod
# see file  /Misc/mod_code_py.pdf
#
import polsar_basics as pb
import polsar_loglikelihood as plk
import polsar_fusion as pf
import polsar_total_loglikelihood as ptl
import polsar_evidence_lib as pel
import polsar_plot as polplt
## This function defines the source image and all the dat related to the region where we want
## to find borders
## Defines the ROI center and the ROI boundaries. The ROI is always a quadrilateral defined from the top left corner
## in a clockwise direction.
def select_data():
    print("Computing Flevoland area - region 1")
    imagem = sys.argv[1]
    ## values adjusted visually - it needs to be defined more preciselly
    ## delta values from the image center to the ROI center
    dx=278
    dy=64
    ## ROI coordinates
    x1 = 157;
    y1 = 284;
    x2 = 309;
    y2 = 281;
    x3 = 310;
    y3 = 327;
    x4 = 157;
    y4 = 330;
    ## inicial angle to start generating the radius
    alpha_i= 0.0
    ## final angle to start generating the radius
    alpha_f= 2 * np.pi
    ## slack constant
    lim = 14
    ## Images name to pdf files
    file_name = []
    file_name.append('img_pauli_flev')
    file_name.append('img_hh_flev')
    file_name.append('img_hv_flev')
    file_name.append('img_vv_flev')
    file_name.append('img_fusion_MEDIA_flev')
    file_name.append('img_fusion_PCA_flev')
    file_name.append('img_fusion_ROC_flev')
    file_name.append('img_fusion_DWT_flev')
    file_name.append('img_fusion_SWT_flev')
    file_name.append('img_fusion_SVD_flev')
    ## Radius length
    RAIO=120
    ## Number of radius used to find evidence considering a whole circunference
    NUM_RAIOS=100
    ## adjust the number of radius based on the angle defined above
    if (alpha_f-alpha_i)!=(2*np.pi):
        NUM_RAIOS=int(NUM_RAIOS*(alpha_f-alpha_i)/(2*np.pi))
    gt_coords=[[x1, y1], [x2, y2], [x3, y3], [x4, y4]]
    #
    return imagem, dx, dy, RAIO, NUM_RAIOS, alpha_i, alpha_f, lim, gt_coords, file_name
#
# The code works as main to tengarss2019 codes
#
## Define the image and the data from the ROI in the image
imagem, dx, dy, RAIO, NUM_RAIOS, alpha_i, alpha_f, lim, gt_coords, file_name = select_data()
#
## Reads the image and return the image, its shape and the number of channels
img, nrows, ncols, nc = pb.le_imagem(imagem)
#
## Plot parameter
img_rt = nrows/ncols
#
## Uses the Pauli decomposition to generate a visible image
## Uses PI as image where we put the radials to show in the image
PI = pb.show_Pauli(img, 1, 0)
## Storage without radiais to show in the image
PISR = pb.show_Pauli(img, 1, 0)
#
## Define the radius in the ROI
x0, y0, xr, yr = pb.define_radiais(RAIO, NUM_RAIOS, dx, dy, nrows, ncols, alpha_i, alpha_f)

MXC, MYC, MY, IT, PI = pb.desenha_raios(ncols, nrows, nc, RAIO, NUM_RAIOS, img, PI, x0, y0, xr, yr)
#
## Define the number of channels (intensity channels) to be used to find evidence
## and realize the fusion in the ROI
ncanal = 3
evidencias = np.zeros((NUM_RAIOS, ncanal))
#
# Find the evidences
evidencias[:, 0] = pel.find_evidence(RAIO, NUM_RAIOS, 0, MY, lim)
evidencias[:, 1] = pel.find_evidence(RAIO, NUM_RAIOS, 1, MY, lim)
evidencias[:, 2] = pel.find_evidence(RAIO, NUM_RAIOS, 2, MY, lim)
## Put the evidences in an image
IM = pel.add_evidence(nrows, ncols, ncanal, evidencias, NUM_RAIOS, MXC, MYC)
#
## Computes fusion using mean - metodo = 1
MEDIA = pf.fusao(IM, 1, NUM_RAIOS)
#
## Computes fusion using pca - metodo = 2
PCA = pf.fusao(IM, 2, NUM_RAIOS)
#
## Computes fusion using ROC - metodo = 3
ROC = pf.fusao(IM, 3, NUM_RAIOS)
#
## Testing fusion using SVD - metodo = 4
SVD = pf.fusao(IM, 4, NUM_RAIOS)
#
## Testing fusion using SWT - metodo = 5
SWT = pf.fusao(IM, 5, NUM_RAIOS)
#
## Testing fusion using DWT - metodo = 6
DWT = pf.fusao(IM, 6, NUM_RAIOS)
#
# The edges evidence images are shown
#
polplt.show_evidence(PISR, NUM_RAIOS, MXC, MYC, evidencias, 0, file_name[1], img_rt)
polplt.show_evidence(PISR, NUM_RAIOS, MXC, MYC, evidencias, 1, file_name[2], img_rt)
polplt.show_evidence(PISR, NUM_RAIOS, MXC, MYC, evidencias, 2, file_name[3], img_rt)
#
# The images with fusion of evidence are shown
#
polplt.show_fusion_evidence(PISR, nrows, ncols, MEDIA, file_name[4], img_rt)
polplt.show_fusion_evidence(PISR, nrows, ncols, PCA, file_name[5], img_rt)
polplt.show_fusion_evidence(PISR, nrows, ncols, ROC, file_name[6], img_rt)
polplt.show_fusion_evidence(PISR, nrows, ncols, DWT, file_name[7], img_rt)
polplt.show_fusion_evidence(PISR, nrows, ncols, SWT, file_name[8], img_rt)
polplt.show_fusion_evidence(PISR, nrows, ncols, SVD, file_name[9], img_rt)
