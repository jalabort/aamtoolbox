function [dw_dp] = ComputeDWDQPR(obj,i)
  %COMPUTEDWDQPR Summary of this function goes here
  %   Detailed explanation goes here

  dw_dxy = obj.w{i}.ComputeDWDXY();
  
  [dx_dq,dy_dq] = obj.sm{i}.ComputeDXYDQ();
  [dx_dp,dy_dp] = obj.sm{i}.ComputeDXYDP(obj.n_p{i});
  [dx_dr,dy_dr] = obj.sm{i}.ComputeDXYDR(obj.n_r(:,i));
 
  jacobian_x = dw_dxy * [dx_dq,dx_dp,dx_dr];
  jacobian_y = dw_dxy * [dy_dq,dy_dp,dy_dr];
  dw_dp = [jacobian_x;jacobian_y];

end

