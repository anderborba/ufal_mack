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
f1 = open("Phantom_gamf_0.000_1_2_1.txt","r" )
f2 = open("Phantom_gamf_0.000_1_2_2.txt","r" )
os.chdir("/home/aborba/ufal_mack/Code/Code_art_rem_sen_2020/Code_python")
# Make manipulation of the files
mat1 = np.loadtxt(f1)
mat2 = np.loadtxt(f2)
dim = mat1.shape[0]
z1 = np.zeros(dim)
z2 = np.zeros(dim)
nr = 49
for i in range(dim):
    z1[i] = mat1[nr][i]
    z2[i] = mat2[nr][i]
w   = np.zeros(dim)
# Make data
x = np.arange(0.05, 5, 0.01)
y = np.arange(0.05, 5, 0.01)
n = x.shape[0]
m = y.shape[0]
level = 49
nli = 1   
nlf = level
s = (n, m)
fz = np.zeros(s)
L = 4 
rho = 0.01
#rho = 4.057504e-07
for i in range(n):
    for j in range(m):
        soma1 = 0
        soma2 = 0
        soma3 = 0
        soma1 = sum(z1[nli:nlf]) 
        soma2 = sum(z2[nli:nlf]) 
        soma3 = sum(np.log(kv(L - 1, 2 * L * np.sqrt((z1[nli:nlf] * z2[nli:nlf]) / (x[i] * y[j])) * rho / (1 - rho**2))))
        #for k in range(nli - 1, nlf):
            #soma1 = soma1 + z1[k] 
            #soma2 = soma2 + z2[k]
            #aux = 2 * L * np.sqrt((z1[k] * z2[k]) / (x[i] * y[j])) * rho / (1 - rho**2)
            #soma3 = soma3 + np.log(kv(L-1, aux))
        aux1  = np.log(1 - rho**2)
        aux2  = (L - 1) * np.log(rho)
        aux3  = 0.5 * (L + 1) * np.log(x[i])
        aux4  = 0.5 * (L + 1) * np.log(y[j])
        aux5 = (L / (x[i] * (1 - rho**2))) * soma1 /  (nlf - (nli - 1))
        aux6 = (L / (y[j] * (1 - rho**2))) * soma2 /  (nlf - (nli - 1))
        aux7 = soma3 / (nlf - (nli - 1))
        fz[i][j] = -aux1 - aux2 - aux3 - aux4 - aux5 - aux6 + aux7
x1, y1 = np.meshgrid(y, x)
surf = ax.plot_surface(x1, y1, fz, cmap=cm.coolwarm, linewidth=0, antialiased=False)
plt.xlabel(r'$\sigma_1$')
plt.ylabel(r'$\sigma_2$')
plt.title(r'Função de máxima verossimilhança $\ell(\sigma_1,\sigma_2)$')
fig.colorbar(surf, shrink=0.5, aspect=5)
plt.show()
# Add a color bar which maps values to colors.
