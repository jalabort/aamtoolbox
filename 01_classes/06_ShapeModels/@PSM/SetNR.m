function [n_r,n_b,n_p] = SetNR(obj,n_r)
  %SetNR Summary of this function goes here
  %   Detailed explanation goes here
  
  diff = (sum(n_r) - sum(obj.n_r));
  n_b = obj.n_b + diff;
  n_p = obj.n_p + diff;
end

