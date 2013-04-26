function [dx_dq,dy_dq] = Compute_dxy_dq(obj)
  %COMPUTE_DXY_DQ Summary of this function goes here
  %   Detailed explanation goes here

  [auxX,auxY] = obj.SimShape2XY(obj.simBasis);
  
  dx_dq = 0.5 * (auxX + 1i*auxY);
  dy_dq = 0.5 * (auxY - 1i*auxX);
  
end

