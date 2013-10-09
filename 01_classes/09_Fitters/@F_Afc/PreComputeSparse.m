function [obj] = PreComputeSparse(obj,i)
  %PreComputeSparse Summary of this function goes here
  %   Detailed explanation goes here
  
  dWduvi = obj.w{i}.Compute_dWduvi();
  obj.dWdp{i} = obj.sm{i}.Compute_dWdp(dWduvi);
  
end

