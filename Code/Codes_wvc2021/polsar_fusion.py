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
import matplotlib.pyplot as plt
## Used in the DWT and SWT fusion methods
import pywt

## This function actually computes an OR between evidences in all channels
def media(IM, FS):
    nrows, ncols, nc = IM.shape
    for i in range(nc):
        FS=FS+IM[:,:,i]
    ##FS=FS/nc
    return FS

## This function computes the fusion of edges based on the PCA technique
def pca(IM, FS):
    nrows, ncols, nc = IM.shape
    ## vectorize the data
    C=np.zeros([nrows*ncols, nc])
    for i in range(nc):
        C[:,i]=np.reshape(IM[:,:,i],[nrows*ncols])
    ## transpose the data vector
    C=np.transpose(C)
    ## Finds the covariance matrix
    COVAR=np.cov(C)
    ## extract the eigenvalues and eigenvectors
    values, vectors=np.linalg.eig(COVAR)
    ## finds the probabilities covered by the eigenvectors
    p=values[:]*1.0/np.sum(values[:])
    ## finds the fusion points based on the probability
    aux=np.zeros([nrows,ncols])
    for i in range(nc):
        aux[:,:]=IM[:,:,i]
        FS=FS+p[i]*aux
    return FS

## Returns the fraction of pixels in the intersection for the value tested
def intersection(I1, I2, test):
    nrows, ncols = I1.shape
    I=0
    ## select the test used for the intersection
    ## edge vs edge
    if test==1:
        value1=1
        value2=1
    ## edge vs n edge
    if test==2:
        value1=1
        value2=0
    ## n edge vs n edge
    if test==3:
        value1=0
        value2=0
    ## n edge vs edge
    if test==4:
        value1=0
        value2=1
    ## computes the intersection
    for i in range(nrows):
        for j in range(ncols):
            if I1[i,j]== value1 and I2[i,j]==value2:
                I=I+1
    ## print(I)
    ## computes the intersection in terms of percentage
    I=I*1.0/(nrows*ncols)
    return I

## computes the average over all channels and the intersection over all channels
def compute_average(I1,I2, nc, test):
    average=np.zeros([nc])
    for j in range(nc):
        soma=0
        for i in range(nc):
            temp=intersection(I1[:,:,j], I2[:,:,i], test)
            soma=soma+temp
            ## print(soma)
        average[j]=soma/nc
    return average

## finds the diagnosis line and computes the distance from each point to the diagnosis line.
## returns the closest point
def findBestFusion(TP,FP, nc, p):
    A=(p-1)/p
    C=1.0
    B=-1.0
    dist=1000
    index=-1
    for i in range(nc):
        d=abs(A*FP[i]+B*TP[i]+C)/np.sqrt(A*A+B*B)
        if d<dist:
            dist=d
            index=i
    return index

## Finds teh fusion over all channels using ROC combination
def roc(IM, FS, NUM_RAIOS):
    nrows, ncols, nc=IM.shape
    V=np.zeros([nrows, ncols])
    M=np.zeros([nrows,ncols, nc])
    ## computes the image will all edge evidence found over the channels
    for i in range(nc):
        V[:,:]=V[:,:]+IM[:,:,i]
    ## finds the M images
    numPointsM1=0
    numPointsM2=0
    numPointsM3=0
    for i in range(nrows):
        for j in range(ncols):
            ## edge evidence found in at least one channel
            if V[i,j]>=1:
                M[i,j,0]=1
                numPointsM1=numPointsM1+1
            ## edge evidence found in at least two channels
            if V[i,j]>=2:
                M[i,j,1]=1
                numPointsM2=numPointsM2+1
            ## edge evidence found in at least three channels
            if V[i,j]>=3:
                M[i,j,2]=1
                numPointsM3=numPointsM3+1
    ## finds the average of true positives
    tp=compute_average(M, IM, nc, 1)
    ## finds the average of the false positives
    fp=compute_average(M, IM, nc, 2)
    ## finds the average of true negatives
    tn=compute_average(M, IM, nc, 3)
    ## finds the average of false negatives
    fn=compute_average(M, IM, nc, 4)
    ## computes the average true positive rates and average false positive rates
    TP=np.zeros([nc])
    FP=np.zeros([nc])
    for i in range(nc):
        TP[i]=tp[i]/(tp[i]+fn[i])
        FP[i]=1.0-(tn[i]/(fp[i]+tn[i]))
    ## finds the value of P
    p=NUM_RAIOS*1.0/(nrows*ncols)
    ## finds the index of the best fusion image
    index=findBestFusion(TP,FP, nc, p)
    FS=M[:,:,index]
    return FS

def dwt(E, m, n, nc):
    # Autors: Anderson Borba and Mauricio Marengoni - Version 1.0 (04/12/2021)
    # Discrete wavelet transform Fusion
    # Input: E     - (m x n x nc) Data with one image per channel
    #        m x n - Image dimension
    #        nc    - Channels number
    # Output: F - Image fusion
    #
    # Calculates DWT to each channel nc
    # Set a list with (mat, tuple) coefficients
    cA = []
    for canal in range(nc):
        cAx, (cHx, cVx, cDx) = pywt.dwt2(E[ :, :, canal], 'db2')
        cA.append([cAx, (cHx, cVx, cDx)])
    #
    # Fusion Method
    # Calculates average to all channels with the coefficients cA from DWT transform
    cAF = 0
    for canal in range(nc):
        cAF = cAF + cA[canal][0]
    cAF = cAF / nc
    #
    # Calculates maximum to all channels with the coefficients cH, cV e Cd from DWT transform
    cHF = np.maximum(cA[0][1][0], cA[1][1][0])
    cVF = np.maximum(cA[0][1][1], cA[1][1][1])
    cDF = np.maximum(cA[0][1][2], cA[1][1][2])
    for canal in range(2, nc):
        cHF = np.maximum(cHF, cA[canal][1][0])
        cVF = np.maximum(cVF, cA[canal][1][1])
        cDF = np.maximum(cDF, cA[canal][1][2])
    #
    # Set the fusion coefficients like (mat, tuple)
    fus_coef = cAF, (cHF, cVF, cDF)
    #
    #Use the transform DWT inverse to obtain the fusion image
    F = pywt.idwt2(fus_coef, 'db2')
    return F

## Implements the MR-SWT Fusion
def swt(E, m, n, nc):
# Stationary wavelet transform Fusion
# Input: E     - (m x n x nc) Data with one image per channel
#        m x n - Image dimension
#        nc    - Channels number
# Output: F - Image fusion
#
# Calculates SWT to each channel nc
# Set a list with (mat, tuple) coefficients
    cA = []
    lis = []
    for canal in range(nc):
        lis = pywt.swt2(E[ :, :, canal], 'sym2', level= 1, start_level= 0)
        cA.append(lis)
    #
    # Fusion Method
    # Calculates the average for all channels with the coefficients cA from the SWT transform
    cAF = 0
    for canal in range(nc):
        cAF = cAF + cA[canal][0][0]
    cAF = cAF/nc
    #
    # Calculates the maximum for all channels with the coefficients cH, cV e Cd from the SWT transform
    cHF = np.maximum(cA[0][0][1][0], cA[0][0][1][0])
    cVF = np.maximum(cA[1][0][1][1], cA[1][0][1][1])
    cDF = np.maximum(cA[2][0][1][2], cA[2][0][1][2])
    for canal in range(2, nc):
        cHF = np.maximum(cHF, cA[canal][0][1][0])
        cVF = np.maximum(cVF, cA[canal][0][1][1])
        cDF = np.maximum(cDF, cA[canal][0][1][2])
    #
    # Set a list with the fusion coefficients like (mat, tuple)
    cF = []
    cF.append([cAF, (cHF, cVF, cDF)])
    F = pywt.iswt2(cF, 'sym2')
    return F

def mr_svd(M, m, n):
    # Direct SVD decomposition multi-resolution
    # Input: M     - (m x n) matrix to SVD decomposition
    #        m x n - Image dimension
    # Output: Return list Y decomposition and matrix U of the SVD decomposition
    #         Where are TLL, TLH, THL, and THH into a list Y
    #
    # Set multi-resolution two level
    m = int(m/2)
    n = int(n/2)
    # Set md to two level SVD decomposition IM.LL, IM.LH, IM.HL, and IM.HH
    # Obs: Each decomposition level split the initial image into 4 matrix
    md = 4
    # Resize M into matrix A[4, m * n]
    A = np.zeros((md, m * n))
    for j in range(n):
        for i in range(m):
            for l in range(2):
                for k in range(2):
                    A[k + l * 2, i + j * m] = M[i * 2 + k, j * 2 + l]
    #
    # Calculate SVD decomposition to A
    U, S, V = np.linalg.svd(A, full_matrices=False)
    UT =  U.transpose()
    T = UT @ A
    # Set each line of T into a vector TLL, TLH, THL, and THH
    TLL = np.zeros((m, n))
    TLH = np.zeros((m, n))
    THL = np.zeros((m, n))
    THH = np.zeros((m, n))
    for j in range(n):
        for i in range(m):
            TLL[i, j] = T[0, i + j * m]
            TLH[i, j] = T[1, i + j * m]
            THL[i, j] = T[2, i + j * m]
            THH[i, j] = T[3, i + j * m]
    #
    # Put TLL, TLH, THL, and THH into a list Y
    Y = []
    Y.append(TLL)
    Y.append(TLH)
    Y.append(THL)
    Y.append(THH)
    # Return Y decomposition and matrix U of the SVD decomposition
    return Y, U


def mr_isvd(Y, U):
    # Inverse SVD decomposition multi-resolution
    # Input: List Y with coeficients and matrix U fusion to SVD inverse decomposition
    #         Where TLL, TLH, THL, and THH are into a list Y
    # Output: Image fusion
    # Define dimension
    dim = Y[0].shape
    m = dim[0]
    n = dim[1]
    mn = dim[0] * dim[1]
    # Put list Y into matrix T[4, m * n]
    # Obs: Each decomposition level split the initial image into 4 matrix
    #
    T = np.zeros((4, mn))
    for j in range(n):
        for i in range(m):
            T[0, i + j * m] = Y[0][i][j]
            T[1, i + j * m] = Y[1][i][j]
            T[2, i + j * m] = Y[2][i][j]
            T[3, i + j * m] = Y[3][i][j]
    #
    # Inverse SVD
    A = U @ T
    # Put A into matrix M
    M = np.zeros((2 * m, 2 * n))
    for j in range(n):
        for i in range(m):
            for l in range(2):
                for k in range(2):
                    M[i * 2 + k, j * 2 + l] = A[k + l * 2, i + j * m]
    # Return the image M
    return M


def svd(E, m, n, nc):
    # SVD multi-resolution Fusion
    # Input: E     - (m x n x nc) Data with one image per channel
    # Output: FS - Image fusion
    # Computes the SVD FUSION
    XC = []
    UC = []
    # Calculate the SVD methods for each image (channel)
    # Storage into two list
    for c in range(nc):
        X, U = mr_svd(E[:, :, c], m, n)
        XC.append(X)
        UC.append(U)
    #
    # Set de dimension
    mr = int(m / 2)
    nr = int(n / 2)
    SOMA = np.zeros((mr, nr))
    XLL  = np.zeros((mr, nr))
    # Calculate the average in alls decompositions X.LL (among channel)
    for c in range(nc):
        SOMA = SOMA + XC[c][0]
    XLL = SOMA / nc
    #
    XF = []
    XF.append(XLL)
    #
    # Obs: Each decomposition level split the initial image into 4 matrix
    nd = 4
    # Calculate the maximum in alls decompositions X.LH, X.HL, and X.HH (among channel)
    for c in range(1, nd):
        D = np.maximum(XC[0][c], XC[1][c])>= 0
        # Element-wise multiplication, and rule to fusion
        XA = D * XC[0][c] + ~D * XC[1][c]
        D = np.maximum(XA, XC[2][c])>= 0
        # Element-wise multiplication, and rule to fusion
        COEF = D * XA + ~D * XC[2][c]
        XF.append(COEF)
    #
    # Rule fusion to matriz list UC
    SOMA1 = np.zeros((4, 4))
    UF    = np.zeros((4, 4))
    for c in range(nc):
        SOMA1 = SOMA1 + UC[c]
    UF = SOMA1 / nc
    IF = mr_isvd(XF, UF)
    return IF

# Choice the fusion methods
def fusao(IM, metodo, NUM_RAIOS):
    nrows, ncols, nc = IM.shape
    FS=np.zeros([nrows,ncols])
    if metodo==1:
        print("finding fusion using mean")
        FS=media(IM, FS)
    if metodo==2:
        print("finding fusion using PCS")
        FS=pca(IM, FS)
    if metodo==3:
        print("finding fusion using ROC")
        FS=roc(IM, FS, NUM_RAIOS)
    if metodo==4:
        print("finding fusion using SVD")
        FS=svd(IM, nrows, ncols, nc )
    if metodo==5:
        print("finding fusion using SWT")
        FS=swt(IM, nrows, ncols, nc)
    if metodo==6:
        print("finding fusion using DWT")
        FS=dwt(IM, nrows, ncols, nc)
    if metodo==7:
        print("finding fusion using Majority")
        FS=majority(IM, FS)
    return FS
#
