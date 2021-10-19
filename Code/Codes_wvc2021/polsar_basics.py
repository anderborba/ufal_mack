## Import all required libraries
import numpy as np
## Used to read images in the mat format
import scipy.io as sio
## Used to equalize histograms in images
from skimage import exposure
import matplotlib as mpl
#
## Read an image in the mat format
def le_imagem(img_geral):
    img=sio.loadmat(img_geral)
    img_dat=img['S']
    img_dat=np.squeeze(img_dat)
    img_shp=img_dat.shape
    ## print(img_shp)
    ncols=img_shp[1]
    nrows=img_shp[0]
    nc=img_shp[len(img_shp)-1]
    return img_dat, nrows, ncols, nc
#
## Uses the Pauli decomposition to viaulalize the POLSAR image
def show_Pauli(data, index, control):
    Ihh = np.real(data[:,:,0])
    Ihv = np.real(data[:,:,1])
    Ivv = np.real(data[:,:,2])
    Ihh=np.sqrt(np.abs(Ihh))
    Ihv=np.sqrt(np.abs(Ihv))/np.sqrt(2)
    Ivv=np.sqrt(np.abs(Ivv))
    R = np.abs(Ihh - Ivv)
    G = (2*Ihv)
    B =  np.abs(Ihh + Ivv)
    R = exposure.equalize_hist(R)
    G = exposure.equalize_hist(G)
    B = exposure.equalize_hist(B)
    Pauli_Image = np.dstack((R,G,B))
    return Pauli_Image
#
## The Bresenham algorithm
## Finds out in what octant the radius is located and translate it to the first octant in order to compute the pixels in the
## radius. It translates the Bresenham line back to its original octant
def bresenham(x0, y0, xf, yf):
    x=xf-x0
    y=yf-y0
    m=10000
    ## avoids division by zero
    if abs(x) > 0.01:
        m=y*1.0/x
    ## If m < 0 than the line is in the 2nd or 4th quadrant
    ## print(x,y, m)
    if m<0:
        ## If |m| <= 1 than the line is in the 4th or in the 8th octant
        if abs(m)<= 1:
            ## If x > 0 than the line is in the 8th octant
            if x>0:
                y=y*-1
                ## print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
                yp=list(np.asarray(yp)*-1)
            ## otherwise the line is in the 4th octant
            else:
                x=x*-1
                ## print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
                xp=list(np.asarray(xp)*-1)
        ## otherwise the line is in the 3rd or 7th octant
        else:
            ## If y > 0 than the line is in the 3rd octant
            if y>0:
                x=x*-1
                x,y = y,x
                ## print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
                xp,yp = yp,xp
                xp=list(np.asarray(xp)*-1)
            ## otherwise the line is in the 7th octant
            else:
                y=y*-1
                x,y = y,x
                ## print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
                xp,yp = yp,xp
                yp=list(np.asarray(yp)*-1)
    ## otherwise the line is in the 1st or 3rd quadrant
    else:
        ## If |m| <= 1 than the line is in the 1st or 5th octant
        if abs(m)<= 1:
            ## if x > 0 than the line is in the 1st octant
            if x>0:
                ##print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
            ## otherwise the line is in the 5th octant
            else:
                x=x*-1
                y=y*-1
                ## print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
                xp=list(np.asarray(xp)*-1)
                yp=list(np.asarray(yp)*-1)
        ## otherwise the line is in the 2nd or 6th octant
        else:
            ## If y > 0 than the line is in the 2nd octant
            if y>0:
                x,y = y,x
                ## print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
                xp,yp = yp,xp
            ## otherwise the line is in the 6th octant
            else:
                y=y*-1
                x=x*-1
                x,y = y,x
                ## print(x,y)
                xp,yp=bresenham_FirstOctante(x,y)
                xp,yp = yp,xp
                xp=list(np.asarray(xp)*-1)
                yp=list(np.asarray(yp)*-1)
    xp= list(np.asarray(xp) + x0)
    yp= list(np.asarray(yp) + y0)
    return xp, yp

## Computes the Bresenham line in the first octant. The implementation is based on the article:
## https://www.tutorialandexample.com/bresenhams-line-drawing-algorithm/

def bresenham_FirstOctante(xf, yf):
    x=int(xf)
    y=int(yf)
    xp=[]
    yp=[]
    xp.append(0)
    yp.append(0)
    x_temp=0
    y_temp=0
    pk=2*y-x
    for i in range(x-1):
        ## print(pk)
        if pk<0:
            pk=pk+2*y
            x_temp=x_temp+1
            y_temp=y_temp
        else:
            pk=pk+2*y-2*x
            x_temp=x_temp+1
            y_temp=y_temp+1
        xp.append(int(x_temp))
        yp.append(int(y_temp))
    xp.append(x)
    yp.append(y)
    return xp, yp


## Define the radius
def define_radiais(r, num_r, dx, dy, nrows, ncols, start, end):
    x0 = ncols / 2 - dx
    y0 = nrows / 2 - dy
    t = np.linspace(start, end, num_r, endpoint=False)
    x = x0 + r * np.cos(t)
    y = y0 + r * np.sin(t)
    xr= np.round(x)
    yr= np.round(y)
    return x0, y0, xr, yr

## Check if the extreme points of each radius are inside the image or not.
def test_XY(XC, YC, j, tam_Y, tam_X):
    if XC[j]<0:
        X=0
    elif XC[j]>=tam_X:
        X=tam_X-1
    else:
        X=XC[j]
    if YC[j]<0:
        Y=0
    elif YC[j]>=tam_Y:
        Y=tam_Y-1
    else:
        Y=YC[j]
    return int(X), int(Y)

## Draw the radius in the image and determine the pixels where
## the image will be sampled using the Bresenham algorithm
def desenha_raios(ncols, nrows, nc, RAIO, NUM_RAIOS, img, PI, x0, y0, xr, yr):
    ## Cria vetors e matrizes de apoio
    IT = np.zeros([nrows, ncols])
    const =  5 * np.max(np.max(np.max(PI)))
    MXC = np.zeros([NUM_RAIOS, RAIO])
    MYC = np.zeros([NUM_RAIOS, RAIO])
    MY  = np.zeros([NUM_RAIOS, RAIO, nc])
    for i in range(NUM_RAIOS):
        XC, YC = bresenham(x0, y0, xr[i], yr[i])
        ##print(XC[0], YC[0], XC[len(XC)-1], YC[len(YC)-1])
        for canal in range(nc):
            Iaux = img[:, :, canal]
            dim = len(XC)
            for j in range(dim-1):
                X,Y = test_XY(XC, YC, j, nrows, ncols)
                MXC[i][j] = X
                MYC[i][j] = Y
                MY[i][j][canal] = Iaux[Y][X]
                IT[Y][X] = const
                PI[Y][X] = const
    return MXC, MYC, MY, IT, PI


## Check the order of the line coordinates in order to call the Bresenham algorithm.
## The Bresenham algorithm assumes that x0 < x1
def verifica_coords(x0, y0, x1, y1):
    flip=0
    if x0>x1:
        x0, x1 = x1, x0
        y0, y1 = y1, y0
        flip=1
    return x0, y0, x1, y1, flip

## Determine the ground truth lines in teh image - it is always a straight line
## The lines are genrated always from the point with the smaller x coordinate to the  point with the larger x coordinate
## Consider the example:
## given the points (10, 15) and (20, 25) generates a ground truth line from (10, 15) to (20, 25)
## given the points (20, 25) and (10, 15) generates a ground truth line from (10, 15) to (20, 25)
## Lines is a list with 4 biary values that indicates what borders of the quadrilateral should be computed
## For instance, if lines[0] = 1 finds the ground truth line that connects the points x1, y1 and x2, y2,
## if lines[1] = 1 finds the ground truth line that connects the points x2, y2 and x3, y3.
## If lines[i]=0 a no ground truth line is computed.

def get_gt_lines(gt_coords, lines):
    '''
    gt_coords:  a list of points coordinates using the xi, yi order from the ROI area
    lines: a vetor indicating the ground truth lines to be computed
    '''
    gt_lines=[]
    for l in range(len(lines)):
        if lines[l]==1:
            if l<3:
                x0, y0, x1, y1, flip=verifica_coords(gt_coords[l][0], gt_coords[l][1], gt_coords[l+1][0], gt_coords[l+1][1])
            else:
                x0, y0, x1, y1, flip=verifica_coords(gt_coords[l][0], gt_coords[l][1], gt_coords[0][0], gt_coords[0][1])
            xp, yp=bresenham(x0, y0, x1, y1)
            if flip==1:
                xp.reverse()
                yp.reverse()
            gt_lines.append([xp,yp])
    return gt_lines
#
## This function computes the indexes from a list where the condition is true
## call: get_indexes(condicao) - example: get_indexes(x>0)
def get_indexes(self):
    try:
        self = list(iter(self))
    except TypeError as e:
        raise Exception("""'get_indexes' method can only be applied to iterables.{}""".format(str(e)))
    indices = [i for i, x in enumerate(self) if bool(x) == True]
    return(indices)
#
