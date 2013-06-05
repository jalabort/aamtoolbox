function [obj] = PreComputeDense(obj,i)
  %PreComputeDense Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();

  obj.dWdp{i} = obj.sm{i}.Compute_duvidp();
  
end

