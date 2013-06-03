function [shape] = B2Shape(obj,b)
  %B2Shape Summary of this function goes here
  %   Detailed explanation goes here

  f = b(1:obj.n_f);
  r = b(obj.n_f+1:end);
  
  shape = obj.R2Shape(r);
  shape = obj.ApplyF(f,shape);
  
end

