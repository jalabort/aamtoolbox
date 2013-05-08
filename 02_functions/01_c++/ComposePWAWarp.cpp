#include <math.h>
#include <mex.h>
#include <iostream>

using namespace std;
  
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  //------------------------------- GATEWAY -------------------------------
  
  //declare variables
  mxArray *a_in, *b_in, *c_in, *d_in, *e_in, *f_in, *g_in, *h_in, *i_in, *j_in, *k_in, *a_out;
  double *annMU, *annInv, *annCurr, *vertInd, *nVert, *sortedTri, *nSortedTri, *triInd, *tri, *nTri, *idMax;
  double *annComp;
  
  //associate inputs
  a_in = mxDuplicateArray(prhs[0]);
  b_in = mxDuplicateArray(prhs[1]);
  c_in = mxDuplicateArray(prhs[2]);
  d_in = mxDuplicateArray(prhs[3]);
  e_in = mxDuplicateArray(prhs[4]);
  f_in = mxDuplicateArray(prhs[5]);
  g_in = mxDuplicateArray(prhs[6]);
  h_in = mxDuplicateArray(prhs[7]);
  i_in = mxDuplicateArray(prhs[8]);
  j_in = mxDuplicateArray(prhs[9]);
  k_in = mxDuplicateArray(prhs[10]);
  
  //associate pointers to the data in the input mxArray
  annMU = mxGetPr(a_in);
  annInv = mxGetPr(b_in);
  annCurr = mxGetPr(c_in);
  vertInd = mxGetPr(d_in);
  nVert = mxGetPr(e_in);
  sortedTri = mxGetPr(f_in);
  nSortedTri = mxGetPr(g_in);
  triInd = mxGetPr(h_in);
  tri = mxGetPr(i_in);
  nTri = mxGetPr(j_in);
  idMax = mxGetPr(k_in);
  
  //associate outputs
  a_out = plhs[0] = mxCreateDoubleMatrix((int)nVert[0],2,mxREAL);
  
  //associate pointers to the data in the output mxArray
  annComp = mxGetPr(a_out);
  
  //-----------------------------------------------------------------------
  
  
  //-------------------------------- CODE ---------------------------------
  
  for (int id=0;id<idMax[0];id++) {
    
    if (id < idMax[0]) 
    {
        int idx = id;
        int idy = idx + (int) nVert[0];

        double tx = annInv[idx];
        double ty = annInv[idy];

        for (int i = (int) triInd[id]; i < (int) triInd[id+1]; i++)
        {

            int idTri = (int) sortedTri[i] - 1;

            int idTriVer1x = (int) tri[idTri] - 1;
            int idTriVer1y = idTriVer1x + (int) nVert[0];
            int idTriVer2x = (int) tri[idTri + (int) nTri[0]] - 1;
            int idTriVer2y = idTriVer2x + (int) nVert[0];
            int idTriVer3x = (int) tri[idTri + 2 * (int) nTri[0]] - 1;
            int idTriVer3y = idTriVer3x + (int) nVert[0];

            double v1x = annMU[idTriVer1x];
            double v1y = annMU[idTriVer1y];
            double v2x = annMU[idTriVer2x];
            double v2y = annMU[idTriVer2y];
            double v3x = annMU[idTriVer3x];
            double v3y = annMU[idTriVer3y];

            double vt1x = annCurr[idTriVer1x];
            double vt1y = annCurr[idTriVer1y];
            double vt2x = annCurr[idTriVer2x];
            double vt2y = annCurr[idTriVer2y];
            double vt3x = annCurr[idTriVer3x];
            double vt3y = annCurr[idTriVer3y];

            double A = v3y - v1y;
            double B = v3x - v1x;
            double C = v2x - v1x;
            double D = v2y - v1y;

            double den = C * A - D * B;

            double a = ((tx - v1x) * A - (ty - v1y) * B) / den;
            double b = ((ty - v1y) * C - (tx - v1x) * D) / den;

            annComp[idx] = annComp[idx] + (vt1x + a * (vt2x - vt1x) + b * (vt3x - vt1x));
            annComp[idy] = annComp[idy] + (vt1y + a * (vt2y - vt1y) + b * (vt3y - vt1y));

        }

        annComp[idx] = annComp[idx] / nSortedTri[id];
        annComp[idy] = annComp[idy] / nSortedTri[id];

    } 
  }
}