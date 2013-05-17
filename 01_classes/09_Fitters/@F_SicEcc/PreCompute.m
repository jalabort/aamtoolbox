function [obj] = PreCompute(obj,level)
  %PRECOMPUTE Summary of this function goes here
  %   Detailed explanation goes here

  obj.dW_dp{level} = obj.Compute_dW_dp(level);
 
  [obj.texModel{level}.dT_dx,obj.texModel{level}.dT_dy] = obj.texModel{level}.Compute_dT_dX(obj.nTexs(level));

end

