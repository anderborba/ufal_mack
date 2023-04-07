### Version 03/08/2021
# Article GRSL
# Ref:
# A. A. De Borba,
# M. Marengoni and
# A. C. Frery,
# "Fusion of Evidences in Intensity Channels for Edge Detection in PolSAR Images,"
# in IEEE Geoscience and Remote Sensing Letters,
#doi: 10.1109/LGRS.2020.3022511.
# bibtex
#@ARTICLE{9203845,
#  author={De Borba, Anderson A. and Marengoni, Maurício and Frery, Alejandro C.},
#  journal={IEEE Geoscience and Remote Sensing Letters},
#  title={Fusion of Evidences in Intensity Channels for Edge Detection in PolSAR Images},
#  year={2020},
#  volume={},
#  number={},
#  pages={1-5},
#  doi={10.1109/LGRS.2020.3022511}}
#
import numpy as np
## Used to find border evidences
import math
#from scipy.optimize import dual_annealing
import matplotlib.pyplot as plt
#
import polsar_loglikelihood as plk
##
# Total Log-likelihood function applies to the sample from l index
# until N (Sample end).
#
# Total Log-likelihood function is used to detect edge evidence.
# input: j - Reference pixel.
#        n - Sample length.
#        z - Sample.
#        matdf1 - Parameters (L, mu) until j.
#        matdf2 - Parameters (L, mu) from j until n.
# output: Total Log-likelihood function value
#
def func_obj_l_L_mu(j, z, n, matdf1, matdf2):
    j = int(np.round(j))
    Le  = matdf1[j, 0]
    mue = matdf1[j, 1]
    Ld  = matdf2[j, 0]
    mud = matdf2[j, 1]
    somaze = sum(z[0: j]) / j
    somalogze = sum(np.log(z[0: j])) / j
    somazd = sum(z[j: n]) / (n - j)
    somalogzd = sum(np.log(z[j: n])) / (n - j)
    #
    aux1 = Le * np.log(Le)
    aux2 = Le * somalogze
    aux3 = Le * np.log(mue)
    aux4 = np.log(math.gamma(Le))
    aux5 = (Le / mue) *  somaze
    #
    aux6  = Ld * np.log(Ld)
    aux7  = Ld * somalogzd
    aux8  = Ld * np.log(mud)
    aux9  = np.log(math.gamma(Ld))
    aux10 = (Ld / mud) * somazd
    a1 =  aux1 + aux2 - aux3 - aux4 - aux5
    a2 =  aux6 + aux7 - aux8 - aux9 - aux10
    #### AAB  Beware! The signal is negative because GenSA finds the point of minimum
    func_obj_l = -(j * a1 + (n - j) * a2)
    return func_obj_l
#
# Total Log-likelihood function is used to detect edge evidence.
# input: j - Reference pixel.
#        n - Sample length.
#        z - Sample.
#        matdf1 - Parameters (L, mu) until j.
#        matdf2 - Parameters (L, mu) from j until n.
# output: Total Log-likelihood function value
#
def func_obj_l_intensity_ratio_tau_rho(j, z, n, matdf1, matdf2, L):
    j = int(np.round(j))
    Le = L
    Ld = L
    taue = matdf1[j, 0]
    rhoe = matdf1[j, 1]
    taud = matdf2[j, 0]
    rhod = matdf2[j, 1]
    aux1 = Le * np.log(taue)
    aux2 = np.log(math.gamma(2 * Le))
    aux3 = Le * np.log(1 - np.abs(rhoe)**2)
    aux4 = 2 * np.log(math.gamma(Le))
    aux5 = sum(np.log(taue + z[0 : j])) / j
    aux6 = Le * sum(np.log(z[0 : j])) / j
    aux7 = (0.5 * (2 * Le + 1)) * sum(np.log((taue + z[0: j])**2 - 4 * taue * np.abs(rhoe)**2 * z[0: j])) / j
    soma1 = aux1 + aux2 + aux3 - aux4 + aux5 + aux6 - aux7
    aux8  = Ld * np.log(taud)
    aux9  = np.log(math.gamma(2 * Ld))
    aux10 = Ld * np.log(1 - abs(rhod)**2)
    aux11 = 2 * np.log(math.gamma(Ld))
    aux12 = sum(np.log(taud + z[j : n])) / (n - j)
    aux13 = Ld * sum(np.log(z[j : n])) / (n - j)
    aux14 = (0.5 * (2 * Ld + 1)) * sum(np.log((taud + z[j: n])**2 - 4 * taud * np.abs(rhod)**2 * z[j: n])) / (n - j)
    soma2 = aux8 + aux9 + aux10 - aux11 + aux12 + aux13 - aux14
    func_obj_l = -(soma1 * j + soma2 * (n - j))
    return func_obj_l
#
# Total Log-likelihood function is used to detect edge evidence.
# input: j - Reference pixel.
#        n - Sample length.
#        z - Sample.
#        matdf1 - Parameters (L, mu) until j.
#        matdf2 - Parameters (L, mu) from j until n.
# output: Total Log-likelihood function value
#
def func_obj_l_intensity_prod(j, z, n, matdf1, matdf2):
    j = int(np.round(j))
    Le   = matdf1[j, 0]
    rhoe = matdf1[j, 1]
    Ld   = matdf2[j, 0]
    rhod = matdf2[j, 1]
    #
    x = np.zeros(2)
    #
    Ni = 0
    Nf = j
    x[0] = Le
    x[1] = rhoe
    soma1 = plk.loglik_intensity_prod(x, z, Ni, Nf)
    #
    Ni = j
    Nf = n
    x[0] = Ld
    x[1] = rhod
    soma2 = plk.loglik_intensity_prod(x, z, Ni, Nf)
    func_obj_l = -(soma1 * j + soma2 * (n - j))
    return func_obj_l
