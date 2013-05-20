function [n_b,n_p] = SetNB(obj,n_b)
  %SetNB Summary of this function goes here
  %   Detailed explanation goes here

  n_p = obj.n_p + (n_b - obj.n_b);

end

