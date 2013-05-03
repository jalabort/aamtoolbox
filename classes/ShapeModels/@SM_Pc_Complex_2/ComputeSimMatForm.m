function [A,t] = ComputeSimMatForm(obj,ann)
  %COMPUTESIMMATFORM Summary of this function goes here
  %   Detailed explanation goes here
  
  muAnn = obj.SimShape2Ann(obj.simMU);
  
  v0x = muAnn(1,1);
  v0y = muAnn(1,2);
  v1x = muAnn(2,1);
  v1y = muAnn(2,2);
  v2x = muAnn(3,1);
  v2y = muAnn(3,2);
        
  vt0x = ann(1,1);
  vt0y = ann(1,2);
  vt1x = ann(2,1);
  vt1y = ann(2,2);
  vt2x = ann(3,1);
  vt2y = ann(3,2);
        
  A = v2y - v0y;
  B = v2x - v0x;
  C = v1x - v0x;
  D = v1y - v0y;

  denominator = C * A - D * B;
        
  F = vt1x - vt0x;
  G = vt2x - vt0x;
  H = vt1y - vt0y;
  I = vt2y - vt0y;
  
  J = (-A * v0x + B * v0y);
  K = (-C * v0y + D * v0x);
        
  a1 = vt0x + (J * F + K * G) / denominator;
  a2 = (A * F - D * G) / denominator;
  a3 = (C * G - B * F) / denominator;
  a4 = vt0y + (J * H + K * I) / denominator;
  a5 = (A * H - D * I) / denominator;
  a6 = (C * I - B * H) / denominator;
            
  A = [a2,a5;a3,a6];
  t = [a1,a4];
  
end