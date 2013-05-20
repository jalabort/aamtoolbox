function [n_l,n_p] = SetNL(obj,n_l)
  %SetNL Summary of this function goes here
  %   Detailed explanation goes here

  n_p = obj.n_p + (n_l - obj.n_l);

end

