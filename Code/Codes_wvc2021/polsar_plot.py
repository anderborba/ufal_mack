import numpy as np
#import pandas as pd
import matplotlib.pyplot as plt
import polsar_total_loglikelihood as ptl
#import cv2
import numpy as np
import os.path
#from PIL import Image
#
def plot_total_likelihood(j, z, N, matdf1, matdf2):
    plt.style.use('ggplot')
    pix = np.zeros(N)
    fob = np.zeros(N)
    for j in range(1, N):
        pix[j] = j
        fob[j] = ptl.func_obj_l_intensity_prod(pix[j], z, N, matdf1, matdf2)
    plt.plot(pix[1:N], fob[1:N])
    plt.show()
#
def show_image(IMG, nrows, ncols, img_rt):
    plt.figure(figsize=(20*img_rt, 20))
    escale = np.mean(IMG) * 2
    plt.imshow(IMG,clim=(0.0, escale), cmap="gray")
    plt.show()
#
def show_image_pauli(IMG, nrows, ncols, img_rt):
    plt.figure(figsize=(20*img_rt, 20))
    plt.imshow(IMG)
    plt.show()
#
def show_image_to_file(IMG, nrows, ncols, image_name):
    directory = './figuras/'
    image = str(image_name) + '.pdf'
    file_path = os.path.join(directory, image)
    escale = np.mean(IMG) * 2
    plt.imsave(file_path, IMG, cmap="gray", vmin = 0, vmax = escale)
    #
def show_image_pauli_to_file(IMG, nrows, ncols, image_name):
    directory = './figuras/'
    image = str(image_name) + '.pdf'
    file_path = os.path.join(directory, image)
    plt.imsave(file_path, IMG)
#
def show_fusion_evidence(pauli, nrows, ncols, FUSION, image_name, img_rt):
    directory = './figuras/'
    image = str(image_name) + '.pdf'
    file_path = os.path.join(directory, image)
    PIA=pauli.copy()
    plt.figure(figsize=(20*img_rt, 20))
    for i in range(nrows):
        for j in range(ncols):
            if(FUSION[i,j] != 0):
                plt.plot(j,i, marker='o', color="darkorange")
    plt.imshow(PIA)
    plt.show(block=False)
    plt.savefig(file_path)
#
## Shows the evidence
def show_evidence(pauli, NUM_RAIOS, MXC, MYC, evidence, banda, image_name, img_rt):
    directory = './figuras/'
    image = str(image_name) + '.pdf'
    file_path = os.path.join(directory, image)
    PIA=pauli.copy()
    plt.figure(figsize=(20*img_rt, 20))
    for k in range(NUM_RAIOS):
        ik = np.int(evidence[k, banda])
        ia = np.int(MXC[k, ik])
        ja = np.int(MYC[k, ik])
        plt.plot(ia, ja, marker='o', color="darkorange")
    plt.imshow(PIA)
    plt.show(block=False)
    plt.savefig(file_path)

