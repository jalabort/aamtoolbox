function [dw_dr] = ComputeDWDR(obj,dw_dxy)
  %COMPUTEDWDR Summary of this function goes here
  %   Detailed explanation goes here
  
  [dx_dr,dy_dr] = obj.ComputeDXYDR();
 
  jacobian_x = dw_dxy * dx_dr;
  jacobian_y = dw_dxy * dy_dr;
  dw_dr = [jacobian_x;jacobian_y];

end

