#include <math.h>
#include <mex.h>
#include <iostream>

using namespace std;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  //------------------------------- GATEWAY -------------------------------
  
  //declare input variables
  double *ann_x, *ann_y, *res_img, *tri, *alphas, *betas, *gammas, *uv_vec, *n_face_pixels, *n_tri, *a_uv;
  
  //associate pointers to the data in the input mxArray
  ann_x = mxGetPr(prhs[0]);
  ann_y = mxGetPr(prhs[1]);
  res_img = mxGetPr(prhs[2]);
  tri = mxGetPr(prhs[3]);
  alphas = mxGetPr(prhs[4]);
  betas = mxGetPr(prhs[5]);
  gammas = mxGetPr(prhs[6]);
  uv_vec = mxGetPr(prhs[7]);
  n_face_pixels = mxGetPr(prhs[8]);
  n_tri = mxGetPr(prhs[9]);
  a_uv = mxGetPr(prhs[10]);
  
  
  //declare output variables
  double *xy, *uv_vec2, *count;
  
  //create the output mxArray
  plhs[0] = mxCreateDoubleMatrix((int)n_face_pixels[0],2,mxREAL);
  plhs[1] = mxCreateDoubleMatrix((int)n_face_pixels[0],1,mxREAL);
  plhs[2] = mxCreateDoubleMatrix(1,1,mxREAL);
  
  //associate pointers to the data in the output mxArray
  xy = mxGetPr(plhs[0]);
  uv_vec2 = mxGetPr(plhs[1]);
  count = mxGetPr(plhs[2]);
  
  //-------------------------------- CODE ---------------------------------
  
  int n_tri2 = 2 * (int)n_tri[0];
  count[0] = 0;
  
  for (int i=0;i<n_tri[0];i++) {
    
    int i1 = (int)tri[i] - 1;
    int i2 = (int)tri[i +  (int)n_tri[0]] - 1;
    int i3 = (int)tri[i + n_tri2] - 1;
    
    double x1 = ann_x[i1] - 1;
    double x2 = ann_x[i2] - 1;
    double x3 = ann_x[i3] - 1;

    double y1 = ann_y[i1] - 1;
    double y2 = ann_y[i2] - 1;
    double y3 = ann_y[i3] - 1;
    
    for (int j=(int)a_uv[i];j<a_uv[i+1];j++) {
      
      double Wu = x1 * gammas[j] + x2 * alphas[j] + x3 * betas[j] + 1;
      double Wv = y1 * gammas[j] + y2 * alphas[j] + y3 * betas[j] + 1;
      
      if ((Wu >= 0) && (Wu < res_img[1]) && (Wv >= 0) && (Wv < res_img[0])) {
              
        xy[(int)count[0]] = Wu;
        xy[(int)count[0] + (int)n_face_pixels[0]] = Wv;
        uv_vec2[(int)count[0]] = uv_vec[j];
        count[0]++;
      }
    }
  }
}