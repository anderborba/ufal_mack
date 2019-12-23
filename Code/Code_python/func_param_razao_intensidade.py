'''
======================
3D surface (color map)
======================

Demonstrates plotting a 3D surface colored with the coolwarm color map.
The surface is made opaque by using antialiased=False.

Also demonstrates using the LinearLocator and custom formatting for the
z axis tick labels.
'''

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
f1 = open("real_flevoland_1.txt","r" )
f2 = open("real_flevoland_2.txt","r" )
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Data")
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code/")
os.chdir("/home/aborba/ufal_mack/Code/Code_python")
# Make manipulation of the files
mat1 = np.loadtxt(f1)
mat2 = np.loadtxt(f2)
dim = mat1.shape[0]
sig = np.zeros(dim)
for i in range(dim):
        sig[i] = mat1[50][i]/mat2[50][i]
# Make data.
x = np.arange(1, 10, 0.01)
y = np.arange(0.01, 1 , 0.01)
x1, y1 = np.meshgrid(y, x)
dimx = x.shape
dimy = y.shape
n = dimx[0]
m = dimy[0]
l = 80
sigma = sig[l]
gamma1 = np.zeros(n)
gamma2 = np.zeros(n)
for i in range(n):
    gamma1[i] = math.gamma(x[i])
    gamma2[i] = math.gamma(2 * x[i])
s = (n, m)
z = np.zeros(s)
for i in range(n):
    for j in range(m):
        aux1 = np.log(gamma2[i]) 
        aux2 = x[i] * np.log(1 - abs(y[j])**2)
        aux3 = np.log(1 + sigma)
        aux4 = (x[i] - 1) * np.log(sigma)
        aux5 = 2 * np.log(gamma1[i])
        aux6 = ((2 * x[i] + 1)/(2)) * np.log((1 + sigma)**2 - 4 * abs(y[j])**2 * sigma)
        z[i][j] = aux1 + aux2 + aux3 + aux4 - aux5 - aux6
surf = ax.plot_surface(x1, y1, z, cmap=cm.coolwarm,
#surf = ax.plot_surface(x1, y1, z, cmap=cm.Spectral,
                       linewidth=0, antialiased=False)

plt.xlabel(r'$\sigma$')
plt.ylabel(r'$L$')
plt.title(r'Função de máxima verossimilhança $\ell(L,\sigma)$')
# Customize the z axis.
#ax.set_zlim(-1.01, 1.01)
#ax.zaxis.set_major_locator(LinearLocator(10))
#ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

# Add a color bar which maps values to colors.
fig.colorbar(surf, shrink=0.5, aspect=5)

plt.show()
