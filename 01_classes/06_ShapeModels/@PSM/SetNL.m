function [n_l,n_b,n_p] = SetNL(obj,n_l)
  %SetNL Summary of this function goes here
  %   Detailed explanation goes here

  diff = (n_l - obj.n_l);
  n_b = obj.n_b + diff;
  n_p = obj.n_p + diff;

end

