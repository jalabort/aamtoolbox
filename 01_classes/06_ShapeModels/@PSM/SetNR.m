function [n_r,n_p] = SetNR(obj,n_r)
  %SetNR Summary of this function goes here
  %   Detailed explanation goes here
  
  n_r = [n_r{:}];
  n_p = obj.n_p + (sum(n_r) - sum(obj.n_r));

end

