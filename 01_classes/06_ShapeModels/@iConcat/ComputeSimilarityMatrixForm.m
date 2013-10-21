function [A,t] = ComputeSimilarityMatrixForm(obj,ann)
  %ComputeSimilarityMatrixForm Summary of this function goes here
  %   Detailed explanation goes here
  
  mu = obj.Shape2Ann(obj.sim_mu);
  
  v0x = mu(1,1);
  v0y = mu(1,2);
  v1x = mu(9,1);
  v1y = mu(9,2);
  v2x = mu(17,1);
  v2y = mu(17,2);
        
  vt0x = ann(1,1);
  vt0y = ann(1,2);
  vt1x = ann(9,1);
  vt1y = ann(9,2);
  vt2x = ann(17,1);
  vt2y = ann(17,2);
        
  a = v2y - v0y;
  b = v2x - v0x;
  c = v1x - v0x;
  d = v1y - v0y;

  den = c * a - d * b;
        
  f = vt1x - vt0x;
  g = vt2x - vt0x;
  h = vt1y - vt0y;
  i = vt2y - vt0y;
  
  j = (-a * v0x + b * v0y);
  k = (-c * v0y + d * v0x);
        
  a1 = vt0x + (j * f + k * g) / den;
  a2 = (a * f - d * g) / den;
  a3 = (c * g - b * f) / den;
  a4 = vt0y + (j * h + k * i) / den;
  a5 = (a * h - d * i) / den;
  a6 = (c * i - b * h) / den;
            
  A = [a2,a5;a3,a6];
  t = [a1,a4];
  
end