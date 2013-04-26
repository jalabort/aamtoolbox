__global__ void cudaWarp(double * warpedImg, const double * indBase, const double * img, const double *resImg1, const double * tri, const double * nTri, const double * pixelTri, const double * x, const double * y, const double * alphas, const double * betas, const double * gammas, const double * idMax) 
{
    int id = threadIdx.x + blockDim.x * blockIdx.x;
    
    if (id < (int) idMax[0]) 
    {
        int idTri = (int) pixelTri[id];

        int idTriVer1 = (int) tri[idTri] - 1;
        int idTriVer2 = (int) tri[idTri + (int) nTri[0]] - 1;
        int idTriVer3 = (int) tri[idTri + 2 * (int) nTri[0]] - 1;

        float x1 = x[idTriVer1] - 1;
        float x2 = x[idTriVer2] - 1;
        float x3 = x[idTriVer3] - 1;

        float y1 = y[idTriVer1] - 1;
        float y2 = y[idTriVer2] - 1;
        float y3 = y[idTriVer3] - 1;

        float alpha = alphas[id];
        float beta = betas[id];
        float gamma = gammas[id];

        float tX = x1 * gamma + x2 * alpha + x3 * beta;
        float tY = y1 * gamma + y2 * alpha + y3 * beta;

        int fTX = floor(tX);
        int fTY = floor(tY);
        int fTX1 = fTX + 1;
        int fTY1 = fTY + 1;

        float dX = tX - fTX;
        float dY = tY - fTY;
        float dX1 = 1 - dX;
        float dY1 = 1 - dY;

        float w1 = dX1 * dY1;
        float w2 = dX  * dY1;
        float w3 = dX1 * dY  ;
        float w4 = dX  * dY  ;

        int aux1 = fTX * resImg1[0];
        int aux2 = fTX1 * resImg1[0];

        int idImg1 = fTY  + aux1;
        int idImg2 = fTY  + aux2;
        int idImg3 = fTY1 + aux1;
        int idImg4 = fTY1 + aux2;

        int uv = (int) indBase[id];

        warpedImg[uv] =  w1 * img[idImg1] + w2 * img[idImg2] + w3 * img[idImg3] + w4 * img[idImg4];

    }

}