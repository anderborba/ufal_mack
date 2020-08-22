# Coded by Anderson Borba data: 29/07/2020 version 1.0
# Article to appear
# Article title
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
# The total log-likelihood Intensity ratio presented in equation (xx) in the article
#
# Input:  j  - Pixel localization
#         L  - Multilook numbers (fixed parameter)
#         rho - parameter (guest parameter)
#         tau - parameter (guest parameter)
# Output: Intensity ratio function value to left(internal) side with j fixed
#
from mpl_toolkits.mplot3d import Axes3D
from scipy.special import kv
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
os.chdir("/home/aborba/ufal_mack/Data/")
f1 = open("Phantom_gamf_0.000_1_2_2.txt","r" )
f2 = open("Phantom_gamf_0.000_1_2_3.txt","r" )
os.chdir("/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Code_python")
# Make manipulation of the files
mat1 = np.loadtxt(f1)
mat2 = np.loadtxt(f2)
dim = mat1.shape[0]
z1 = np.zeros(dim)
z2 = np.zeros(dim)
nr = 34
for i in range(dim):
    z1[i] = mat1[nr][i]
    z2[i] = mat2[nr][i]
z   = np.zeros(dim)
for i in range(dim):
    z[i] = z1[i] / z2[i]
# Make data
x = np.arange(0.01, 5, 0.01)
y = np.arange(0.01, 1, 0.05)
n = x.shape[0]
m = y.shape[0]
gamma = np.zeros(n)
#for i in range(n):
#    gamma[i] = math.gamma(x[i])
pix = 150
nli = 1
L = 4
nlf = pix
s = (n, m)
fz = np.zeros(s)
soma1 = 0
soma2 = 0
for i in range(n):
    for j in range(m):
        soma1 = sum(np.log(x[i] + z[1:pix]))
        soma2 = sum(np.log((x[i] + z[1:pix])**2 - 4 * x[i] * abs(y[j])**2 * z[1: pix]))
        aux1 = L * np.log(x[i])
        aux2 = L * np.log(1 - abs(y[j])**2)
        aux3 =                       soma1 / pix
        aux4 = (0.5 * (2 * L + 1)) * soma2 / pix
        fz[i][j] = aux1 + aux2 + aux3 - aux4
x1, y1 = np.meshgrid(y, x)
surf = ax.plot_surface(x1, y1, fz, cmap=cm.coolwarm, linewidth=0, antialiased=False)
plt.ylabel(r'$\tau$')
plt.xlabel(r'$\rho$')
#plt.title(r'Log-likelihood function $\ell(\rho,\tau)$')
plt.title(r'Função log-verossimilhança $\ell(\rho,\tau)$')
fig.colorbar(surf, shrink=0.5, aspect=5)
plt.show()
# Add a color bar which maps values to colors.
