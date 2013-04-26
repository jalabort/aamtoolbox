function [dw_dp] = ComputeDWDP(obj,dw_dxy)
  %COMPUTEDWDP Summary of this function goes here
  %   Detailed explanation goes here
  
  [dx_dp,dy_dp] = obj.ComputeDXYDP();
 
  jacobian_x = dw_dxy * dx_dp;
  jacobian_y = dw_dxy * dy_dp;
  dw_dp = [jacobian_x;jacobian_y];

end

