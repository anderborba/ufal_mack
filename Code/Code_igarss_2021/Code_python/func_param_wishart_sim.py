from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np
import math
import os
from scipy.optimize import minimize
# Function Definition
def func_pdf_gamma(x, sigma1, sigma2):
            aux1 = x[0] * np.log(x[0] / x[1])
            aux2 = x[0] * sigma1
            aux3 =  np.log(math.gamma(x[0]))
            aux4 = (x[0] / x[1]) * sigma2
            #z = - (aux1 + aux2 - aux3 - aux4)
            z = (x[0] - sigma1)**2 + (x[1] - sigma2)**2
            return z
#
plt.rc('text', usetex=True)
fig = plt.figure()
ax = fig.gca(projection='3d')
# Make a read
os.chdir("/home/aborba/ufal_mack/Code/Code_igarss_2021/Data")
f = open("Phantom_gamf_0.000_1_2_3.txt","r")
os.chdir("/home/aborba/ufal_mack/Code/Code_igarss_2021/Code_python")
# Make manipulation of the files
mat = np.loadtxt(f)
dim = mat.shape[1]
sig = np.zeros(dim)
for i in range(dim):
        sig[i] = mat[150][i]
# Make data
x = np.arange(0.1, 5, 0.1)
y = np.arange(0.005, 0.5 , 0.01)
x1, y1 = np.meshgrid(y, x)
dimx = x.shape
dimy = y.shape
n = dimx[0]
m = dimy[0]
l = 100
sigma1 = sum(np.log(sig[0:l])) / l 
sigma2 = sum(sig[0:l]) / l
gamma = np.zeros(n)
for i in range(n):
    gamma[i] = math.gamma(x[i])
s = (n, m)
z = np.zeros(s)
x0 = np.array([0.0, 0.0])
#for i in range(0, n):
#    for j in range(0, m):
#for i in range(0, 0):
#    for j in range(0, 0):
#        x0[0] = x[i]
#        x0[1] = y[j]
#        z[i][j] = func_pdf_gamma(x0, sigma1, sigma2, gamma[i])
x0 = np.array([1.0, 1.0])
res = minimize(func_pdf_gamma, x0, args=(sigma1, sigma2),  method='BFGS', options={'disp': True})
#        
#surf = ax.plot_surface(x1, y1, z, cmap=cm.coolwarm,
#                       linewidth=0, antialiased=False)
#
#plt.xlabel(r'$\mu$')
#plt.ylabel(r'$L$')
#plt.title(r'Log - likelihood $\mathcal{L}(L,\mu)$')
# Add a color bar which maps values to colors.
#fig.colorbar(surf, shrink=0.5, aspect=5)
#plt.show()
#
#x0 = np.array([1.0, 1.0])
#res = minimize(rosen, x0, method='BFGS', jac=rosen_der,
#               options={'disp': True})
#res = minimize(func_pdf_gamma, x0, method='BFGS',
#               options={'disp': True})
