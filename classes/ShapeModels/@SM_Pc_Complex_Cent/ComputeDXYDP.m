function [dx_dp,dy_dp] = ComputeDXYDP(obj)
  %COMPUTEDXYDP Summary of this function goes here
  %   Detailed explanation goes here

  [auxX,auxY] = obj.Shape2XY(obj.pc(:,1:obj.n_p));

  dx_dp = 0.5 * (auxX + 1i*auxY);
  dy_dp = 0.5 * (auxY - 1i*auxX);
  
end

