function [A,t] = computeaffinebetwennpoints(p,pp)
  %computeaffinebetwennpoints Summary of this function goes here
  %   Detailed explanation goes here
  
  v0x = p(1,1);
  v0y = p(1,2);
  v1x = p(2,1);
  v1y = p(2,2);
  v2x = p(3,1);
  v2y = p(3,2);
        
  vt0x = pp(1,1);
  vt0y = pp(1,2);
  vt1x = pp(2,1);
  vt1y = pp(2,2);
  vt2x = pp(3,1);
  vt2y = pp(3,2);
        
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