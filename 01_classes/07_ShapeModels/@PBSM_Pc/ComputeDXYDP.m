function [dx_dp,dy_dp] = ComputeDXYDP(obj)
  %COMPUTEDXYDP Summary of this function goes here
  %   Detailed explanation goes here

  [dx_dp,dy_dp] = obj.Shape2XY(obj.mass_pc(:,1:obj.n_p));

end

