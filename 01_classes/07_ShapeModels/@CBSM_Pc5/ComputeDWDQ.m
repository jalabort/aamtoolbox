function [dw_dq] = ComputeDWDQ(obj,dw_dxy)
  %COMPUTEDWDQ Summary of this function goes here
  %   Detailed explanation goes here
  
  [dx_dq,dy_dq] = obj.ComputeDXYDQ();
 
  jacobian_x = dw_dxy * dx_dq;
  jacobian_y = dw_dxy * dy_dq;
  dw_dq = [jacobian_x;jacobian_y];

end

