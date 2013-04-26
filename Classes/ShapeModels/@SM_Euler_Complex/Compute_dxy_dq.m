function [dx_dq,dy_dq] = Compute_dxy_dq(obj)
  %COMPUTE_DXY_DQ Summary of this function goes here
  %   Detailed explanation goes here

  [dx_dq,dy_dq] = obj.SimShape2XY(obj.simBasis);

end

