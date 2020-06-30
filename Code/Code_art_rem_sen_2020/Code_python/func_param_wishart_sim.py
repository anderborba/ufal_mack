# Coded by Anderson Borba data: 09/06/2020 version 1.0 
# Fusion of Evidences in Intensities Channels for Edge Detection in PolSAR Images
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
# The total log-likelihood presented in equation (xx) in the article
#
# Input:  j  - Pixel localization
#         L  - Multilook numbers (guest parameter)
#         mu - Intensity channel (guest parameter)
# Output: Gamma function value to left(internal) side with j fixed
#
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np
import math
import os
plt.rc('text', usetex=True)
fig = plt.figure()
ax = fig.gca(projection='3d')
# Make a read
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code")
os.chdir("/home/aborba/ufal_mack")
os.chdir("/home/aborba/ufal_mack/Data/")
f = open("Phantom_gamf_0.000_1_2_1.txt","r" )
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Data")
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code/")
os.chdir("/home/aborba/ufal_mack/Code/Code_python")
# Make manipulation of the files
mat = np.loadtxt(f)
dim = mat.shape[1]
sig = np.zeros(dim)
for i in range(dim):
        sig[i] = mat[50][i]
# Make data
x = np.arange(0.1, 5, 0.1)
y = np.arange(0.005, 0.5 , 0.01)
x1, y1 = np.meshgrid(y, x)
dimx = x.shape
dimy = y.shape
n = dimx[0]
m = dimy[0]
# fixed pixel
l = 100
sigma1 = sum(np.log(sig[0:l])) / l 
sigma2 = sum(sig[0:l]) / l
gamma = np.zeros(n)
for i in range(n):
    gamma[i] = math.gamma(x[i])
s = (n, m)
z = np.zeros(s)
for i in range(n):
    for j in range(m):
        aux1 = x[i] * np.log(x[i]) 
        aux2 = (x[i] - 1) * sigma1
        aux3 = x[i] * np.log(y[j])
        aux4 =  np.log(gamma[i])
        aux5 = (x[i] / y[j]) * sigma2
        z[i][j] = aux1 + aux2 - aux3 - aux4 - aux5
surf = ax.plot_surface(x1, y1, z, cmap=cm.coolwarm,
                       linewidth=0, antialiased=False)

plt.xlabel(r'$\mu$')
plt.ylabel(r'$L$')
plt.title(r'Log - likelihood $\ell(L,\mu)$')
# Add a color bar which maps values to colors.
fig.colorbar(surf, shrink=0.5, aspect=5)
plt.show()
