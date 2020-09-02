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
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code/Code_python")
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
y = np.arange(0.05, 1, 0.01)
n = x.shape[0]
m = y.shape[0]
level = 49
nli = 1   
nlf = level
s = (n, m)
fz = np.zeros(s)
L = 4 
rho = 0.1
#rho = 4.057504e-07
for i in range(n):
    for j in range(m):
        soma1 = 0
        soma2 = 0
        soma3 = 0
        soma4 = 0
        soma5 = 0
        for k in range(nli - 1, nlf):
            soma1 = soma1 + np.log(z1[k]) 
            soma2 = soma2 + np.log(z2[k])
            soma3 = soma3 + z1[k] 
            soma4 = soma4 + z2[k]
            aux = 2 * L * np.sqrt((z1[k] * z2[k]) / (x[i] * y[j])) * rho / (1 - rho**2)
            soma5 = soma5 + np.log(kv(L-1, aux))
        aux1  = (L + 1) * np.log(L)
        aux2  = np.log(math.gamma(L))
        aux3  = np.log(1 - rho**2)
        aux4  = (L - 1) * np.log(rho)
        aux5  = 0.5 * L * np.log(x[i])
        aux6  = 0.5 * L * np.log(y[j])
        aux7  = 0.5 * L * soma1 /  (nlf - (nli - 1))
        aux8  = 0.5 * L * soma2 /  (nlf - (nli - 1))
        aux9  = (L / (x[i] * (1 - rho**2))) * soma3 /  (nlf - (nli - 1))
        aux10 = (L / (y[j] * (1 - rho**2))) * soma4 /  (nlf - (nli - 1))
        aux11 = soma5 / (nlf - (nli - 1))
        fz[i][j] = aux1 - aux2 - aux3 - aux4 - aux5 - aux6 + aux7 + aux8 - aux9 - aux10 + aux11
x1, y1 = np.meshgrid(y, x)
surf = ax.plot_surface(x1, y1, fz, cmap=cm.coolwarm, linewidth=0, antialiased=False)
plt.xlabel(r'$\sigma_1$')
plt.ylabel(r'$\sigma_2$')
plt.title(r'Função de máxima verossimilhança $\ell(L,\rho,\sigma_1,\sigma_2)$')
fig.colorbar(surf, shrink=0.5, aspect=5)
plt.show()
# Add a color bar which maps values to colors.
