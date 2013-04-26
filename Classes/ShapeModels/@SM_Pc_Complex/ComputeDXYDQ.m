function [dx_dq,dy_dq] = ComputeDXYDQ(obj)
  %COMPUTEDXYDQ Summary of this function goes here
  %   Detailed explanation goes here

  [auxX,auxY] = obj.Shape2XY(obj.sim_basis);

  dx_dq = 0.5 * (auxX + 1i*auxY);
  dy_dq = 0.5 * (auxY - 1i*auxX);
  
end

