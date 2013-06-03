function [obj] = PreCompute(obj,i)
  %PreCompute Summary of this function goes here
  %   Detailed explanation goes here
  
 obj.t{i} = obj.tm{i}.GetMean();

  obj.dWduvi{i} = obj.w{i}.Compute_dWduvi();
  
end

