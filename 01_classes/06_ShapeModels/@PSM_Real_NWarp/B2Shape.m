function [shape] = B2Shape(obj,b)
  %B2Shape Summary of this function goes here
  %   Detailed explanation goes here

  l = b(1:obj.n_l);
  f = b(obj.n_l+1:obj.n_l+obj.n_f);
  r = b(obj.n_l+obj.n_f+1:end);
  
  shape = obj.R2Shape(r);
  shape = obj.ApplyF(f,shape);
  shape = obj.ApplyL(l,shape);
  
end

