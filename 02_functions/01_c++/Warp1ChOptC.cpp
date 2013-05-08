#include <math.h>
#include <mex.h>
#include <iostream>

using namespace std;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  //------------------------------- GATEWAY -------------------------------
  
  //declare variables
  mxArray *a_in, *b_in, *c_in, *d_in, *e_in, *f_in, *g_in, *h_in, *i_in, *j_in, *k_in, *l_in, *m_in, *a_out;
  double *res_wimg, *i_base, *res_img, *tri, *n_tri, *pixel_tri, *id_max; 
  double *img, *x, *y, *alphas, *betas, *gammas, * wimg;
  
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
  l_in = mxDuplicateArray(prhs[11]);
  m_in = mxDuplicateArray(prhs[12]);
  
  //associate pointers to the data in the input mxArray
  res_wimg = mxGetPr(a_in);
  i_base = mxGetPr(b_in);
  img = mxGetPr(c_in);
  res_img = mxGetPr(d_in);
  tri = mxGetPr(e_in);
  n_tri = mxGetPr(f_in);
  pixel_tri = mxGetPr(g_in);
  x = mxGetPr(h_in);
  y = mxGetPr(i_in);
  alphas = mxGetPr(j_in);
  betas = mxGetPr(k_in);
  gammas = mxGetPr(l_in);
  id_max = mxGetPr(m_in);
  
  //associate outputs
  a_out = plhs[0] = mxCreateDoubleMatrix((int)res_wimg[0],(int)res_wimg[1],mxREAL);
  
  //associate pointers to the data in the output mxArray
  wimg = mxGetPr(a_out);
  
  //-----------------------------------------------------------------------
  
  //-------------------------------- CODE ---------------------------------
  
  int max = (int) res_img[0] * (int) res_img[1]; 
  int min = 0; 
  
  for (int id=0;id<id_max[0];id++) {
    
    int i_tri = (int) pixel_tri[id] - 1;

    int i_tri_vert1 = (int) tri[i_tri] - 1;
    int i_tri_vert2 = (int) tri[i_tri +  (int) n_tri[0]] - 1;
    int i_tri_vert3 = (int) tri[i_tri + 2 *  (int) n_tri[0]] - 1;

    double x1 = x[i_tri_vert1] - 1;
    double x2 = x[i_tri_vert2] - 1;
    double x3 = x[i_tri_vert3] - 1;

    double y1 = y[i_tri_vert1] - 1;
    double y2 = y[i_tri_vert2] - 1;
    double y3 = y[i_tri_vert3] - 1;

    double alpha = alphas[id];
    double beta = betas[id];
    double gamma = gammas[id];

    double tx = x1 * gamma + x2 * alpha + x3 * beta;
    double ty = y1 * gamma + y2 * alpha + y3 * beta;

    int ftx = (int) floor(tx);
    int fty = (int) floor(ty);
    int ftx1 = (int) ftx + 1;
    int fty1 = (int) fty + 1;

    double dx = tx - ftx;
    double dy = ty - fty;
    double dx1 = 1 - dx;
    double dy1 = 1 - dy;

    double w1 = dx1 * dy1;
    double w2 = dx  * dy1;
    double w3 = dx1 * dy;
    double w4 = dx  * dy;

    int aux1 = (int) ftx * (int) res_img[0];
    int aux2 = (int) ftx1 * (int) res_img[0];

    int i_img1 = (int) fty  + aux1;
    int i_img2 = (int) fty  + aux2;
    int i_img3 = fty1 + aux1;
    int i_img4 = fty1 + aux2;

    int uv = (int) i_base[id] - 1;
    
    if ((i_img1 >= min) && (i_img1 < max) && (i_img2 >= min) && (i_img2 < max) && (i_img3 >= min) && (i_img3 < max) && (i_img4 >= min) && (i_img4 < max))
    {
      wimg[uv] = w1 * img[i_img1] + w2 * img[i_img2] + w3 * img[i_img3] + w4 * img[i_img4];
    }
  }
}