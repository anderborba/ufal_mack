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
f2 = open("Phantom_gamf_0.000_1_2_2.txt","r" )
f3 = open("Phantom_gamf_0.000_1_2_4.txt","r" )
f4 = open("Phantom_gamf_0.000_1_2_5.txt","r" )
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Data")
os.getcwd()
os.chdir("/home/aborba/ufal_mack/Code/")
os.chdir("/home/aborba/ufal_mack/Code/Code_python")
# Make manipulation of the files
mat1 = np.loadtxt(f1)
mat2 = np.loadtxt(f2)
mat3 = np.loadtxt(f3)
mat4 = np.loadtxt(f4)
dim = mat1.shape[0]
z1 = np.zeros(dim)
z2 = np.zeros(dim)
z3 = np.zeros(dim)
z4 = np.zeros(dim)
nr = 34
for i in range(dim):
    z1[i] = mat1[nr][i]
    z2[i] = mat2[nr][i]
    z3[i] = mat3[nr][i]
    z4[i] = mat4[nr][i]
zaux1 = np.zeros(dim)
zaux2 = np.zeros(dim)
ksi   = np.zeros(dim)
for i in range(dim):
    zaux1[i] = np.sqrt(z3[i]**2 + z4[i]**2)
    zaux2[i] = np.sqrt(z1[i] * z2[i])
    ksi[i] = zaux1[i] / zaux2[i] 
# Make data
x = np.arange(1, 20, 0.1)
y = np.arange(0, 1, 0.05)
#y = np.arange(0.001/1.25, 0.1 , 0.001/1.25)
#y = np.arange(0.001, 0.03 , 0.01)
n = x.shape[0]
m = y.shape[0]
gamma = np.zeros(n)
for i in range(n):
    gamma[i] = math.gamma(x[i])
level = 350
nli = level + 1   
nlf = dim
s = (n, m)
fz = np.zeros(s)
for i in range(n):
    for j in range(m):
        soma1 = 0
        soma2 = 0
        soma3 = 0
        for k in range(nli - 1, nlf):
            soma1 = soma1 + np.log(ksi[k]) 
            soma2 = soma2 + np.log(np.i0((2 * y[j] * x[i] * ksi[k]) / (1 - y[j]**2)))
            soma3 = soma3 + np.log(kv(x[i] - 1, (2 * x[i] * ksi[k]) / (1 - y[j]**2)))
        aux1 = (x[i] + 1) * np.log(x[i]) - np.log(gamma[i]) - np.log(1 - y[j]**2)
        aux2 = x[i] * soma1 / (nlf - (nli - 1))
        aux3 =  soma2 / (nlf - (nli - 1))
        aux4 =  soma3 / (nlf - (nli - 1))
        fz[i][j] = aux1 + aux2 + aux3 + aux4
x1, y1 = np.meshgrid(y, x)
surf = ax.plot_surface(x1, y1, fz, cmap=cm.coolwarm, linewidth=0, antialiased=False)
plt.xlabel(r'$\rho$')
plt.ylabel(r'$L$')
plt.title(r'Função de máxima verossimilhança $\ell(L,\rho)$')
fig.colorbar(surf, shrink=0.5, aspect=5)
plt.show()
# Add a color bar which maps values to colors.
