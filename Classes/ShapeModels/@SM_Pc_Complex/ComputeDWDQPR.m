function [dw_dp] = ComputeDWDQPR(obj,dw_dxy)
  %COMPUTEDWDQPR Summary of this function goes here
  %   Detailed explanation goes here
  
  [dx_dq,dy_dq] = obj.ComputeDXYDQ();
  [dx_dp,dy_dp] = obj.ComputeDXYDP();
 
  jacobian_x = dw_dxy * [dx_dq,dx_dp];
  jacobian_y = dw_dxy * [dy_dq,dy_dp];
  dw_dp = [jacobian_x;jacobian_y];

end

