from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy as np
#import math
#import os
from scipy.optimize import minimize
# Function Definition
def func_pdf_gamma(x, a, b):
    z =  (x[0] - a)**2 + (x[1] - b)**2
    return z
#
x0 = np.array([1.0, 1.0])
a = 2
b = 2
res = minimize(func_pdf_gamma, x0, args=(a , b), method='BFGS', options={'disp': True})
