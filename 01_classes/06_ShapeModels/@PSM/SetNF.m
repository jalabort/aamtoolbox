function [n_f,n_b,n_p] = SetNF(obj,n_f)
  %SetNF Summary of this function goes here
  %   Detailed explanation goes here

  diff = (n_f - obj.n_f);
  n_b = obj.n_b + diff;
  n_p = obj.n_p + diff;

end

