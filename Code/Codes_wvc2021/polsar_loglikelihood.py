import numpy as np
# import special functions (Bessel)
from scipy.special import kv
from scipy.special import iv
## Used to find border evidences
import math
#
# Log likelihood function to gamma distribution until l index.
# Ref: Fusion of Evidences in Intensity Channels for Edge Detection in PolSAR Images
# IEEE Geoscience and Remote Sensing Letters
# DOI: 10.1109/LGRS.2020.3022511
#
# Log-likelihood function is used to estimate parameters (L, mu).
# input: x - Vector with (L, mu) to evaluate.
#        j - Reference pixel.
#        z - Sample.
# output: Log-likelihood function value
#
def loglike(x, z, j):
    L  = x[0]
    mu = x[1]
    aux1 = L * np.log(L)
    aux2 = L * sum(np.log(z[0: j])) / j
    aux3 = L * np.log(mu)
    aux4 = np.log(math.gamma(L))
    aux5 = (L / mu) * sum(z[0: j]) / j
    #### Beware! The signal is negative because BFGS routine finds the point of minimum
    ll   = -(aux1 + aux2 - aux3 - aux4 - aux5)
    return ll
#
# Log-likelihood gamma distribution function applies to the sample from l index
# until N (Sample end).
# Ref: Fusion of Evidences in Intensity Channels for Edge Detection in PolSAR Images
# IEEE Geoscience and Remote Sensing Letters
# DOI: 10.1109/LGRS.2020.3022511
#
# Log-likelihood function is used to estimate parameters (L, mu).
# input: x - Vector with (L, mu) to evaluate.
#        j - Reference pixel.
#        n - Samplo size.
#        z - Sample.
# output: Log-likelihood function value
#
def loglikd(x, z, j, n):
    L  = x[0]
    mu = x[1]
    aux1 = L * np.log(L)
    aux2 = L * sum(np.log(z[j: n])) / (n - j)
    aux3 = L * np.log(mu)
    aux4 = np.log(math.gamma(L))
    aux5 = (L / mu) * sum(z[j: n]) / (n - j)
    #### Beware! The signal is negative because BFGS routine finds the point of minimum
    ll =  -(aux1 + aux2 - aux3 - aux4 - aux5)
    return ll
#
# Log likelihood function to intensity ratio distribution .
# Ref: Intensity and phase statistics of multilook
# polarimetric and interferometric SAR imagery
#IEEE Transactions on Geoscience and Remote Sensing
#     ( Volume: 32, Issue: 5, Sep 1994)
# DOI: 10.1109/36.312890
#
# Log-likelihood function is used to estimate parameters (tau, rho).
# input: Vector with (tau, rhi) to evaluate.
#        L = 4 fixed
#        Ni - sample start
#        Nf - end of sample.
#        z - Sample.
# output: Log-likelihood function value
#
def loglik_intensity_ratio(x, z, Ni, Nf, L):
    tau = x[0]
    rho = x[1]
    soma1 = 0
    soma2 = 0
    soma3 = 0
    for k in range(Ni, Nf + 1):
        soma1 = soma1 + np.log(tau + z[k])
        soma2 = soma2 + np.log(z[k])
        soma3 = soma3 + np.log((tau + z[k])**2 - 4 * tau * np.abs(rho)**2 * z[k])
    #
    aux1 = L * np.log(tau)
    aux2 = np.log(math.gamma(2 * L))
    aux3 = L * np.log(1 - np.abs(rho)**2)
    aux4 = 2 * np.log(math.gamma(L))
    aux5 = soma1 / (Nf + 1 - Ni)
    aux6 = L * soma2 / (Nf + 1 - Ni)
    aux7 = (0.5 * (2 * L + 1)) * soma3 / (Nf + 1 - Ni)
    #### Beware! The signal is negative because BFGS routine finds the point of minimum
    ll = -(aux1 + aux2 + aux3 - aux4 + aux5 + aux6 - aux7)
    return ll
#
# Log-likelihood function is used to estimate parameters (tau, rho).
# input: Vector with (tau, rhi) to evaluate.
#        L = 4 fixed
#        Ni - sample start
#        Nf - end of sample.
#        z - Sample.
# output: Log-likelihood function value
#
def loglik_intensity_prod(x, z, Ni, Nf):
    L   = x[0]
    rho = x[1]
    rho = np.abs(x[1])
    #
    soma1 = 0
    soma2 = 0
    for k in range(Ni, Nf):
        soma1 = soma1 + np.log(iv(0, 2 * np.abs(rho) * L * z[k] / ((1 - rho**2))))
        soma2 = soma2 + np.log(kv(L - 1, 2 * L * z[k] /           ((1 - rho**2))))
    #
    aux1 = (L + 1) * np.log(L)
    aux2 = L * sum(z[Ni: Nf]) / (Nf + 1 - Ni)
    aux3 = np.log(math.gamma(L))
    aux4 = np.log(1 - rho**2)
    aux5 = soma1 / (Nf + 1 - Ni)
    aux6 = soma2 / (Nf + 1 - Ni)
    ####Beware! The signal is negative because BFGS routine finds the point of minimum
    ll = -(aux1 + aux2 - aux3 - aux4 + aux5 + aux6)
    return ll
