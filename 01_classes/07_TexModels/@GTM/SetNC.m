function [n_c,variance] = SetNC(obj,n_c)
  %SetNC Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.n_c = n_c;
  variance = obj.ComputeLeftOutVariance();

end

