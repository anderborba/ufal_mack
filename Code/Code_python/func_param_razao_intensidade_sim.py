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
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code")
os.chdir("/home/aborba/ufal_mack")
os.chdir("/home/aborba/ufal_mack/Data/")
f1 = open("Phantom_gamf_0.000_1_2_1.txt","r" )
f2 = open("Phantom_gamf_0.000_1_2_3.txt","r" )
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Data")
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code/")
os.chdir("/home/aborba/ufal_mack/Code/Code_python")
# Make manipulation of the files
mat1 = np.loadtxt(f1)
mat2 = np.loadtxt(f2)
dim = mat1.shape[0]
z1 = np.zeros(dim)
z2 = np.zeros(dim)
nr = 79
for i in range(dim):
    z1[i] = mat1[nr][i]
    z2[i] = mat2[nr][i]
w   = np.zeros(dim)
for i in range(dim):
    w[i] = z1[i] / z2[i] 
# Make data
x = np.arange(0.05, 10, 0.1)
y = np.arange(0, 1, 0.05)
n = x.shape[0]
m = y.shape[0]
gamma1 = np.zeros(n)
gamma2 = np.zeros(n)
level = 350
nli = 1   
nlf = level
s = (n, m)
fz = np.zeros(s)
L = 4 
for i in range(n):
    gamma1[i] = math.gamma(2 * L)
    gamma2[i] = math.gamma(L)
for i in range(n):
    for j in range(m):
        soma1 = 0
        soma2 = 0
        soma3 = 0
        for k in range(nli - 1, nlf):
            soma1 = soma1 + np.log(x[i] + w[k]) 
            soma2 = soma2 + np.log(w[k])
            soma3 = soma3 + np.log((x[i] + w[k])**2 - 4 * x[i] * y[j]**2 * w[k])
        aux1 = L * np.log(x[i])
        aux2 = np.log(gamma1[i])
        aux3 = L * np.log(1 - y[j]**2) 
        aux4 = 2 * np.log(gamma2[i])
        aux5 =      soma1 / (nlf - (nli - 1))
        aux6 =  L * soma2 / (nlf - (nli - 1))
        aux7 =  (0.5 * (2 * L + 1)) *    soma3 / (nlf - (nli - 1))
        fz[i][j] = aux1 + aux2 + aux3 - aux4 + aux5 + aux6 - aux7
x1, y1 = np.meshgrid(y, x)
surf = ax.plot_surface(x1, y1, fz, cmap=cm.coolwarm, linewidth=0, antialiased=False)
plt.xlabel(r'$\rho$')
plt.ylabel(r'$\tau$')
plt.title(r'Função de máxima verossimilhança $\ell(L,\rho,\tau)$')
fig.colorbar(surf, shrink=0.5, aspect=5)
plt.show()
# Add a color bar which maps values to colors.
