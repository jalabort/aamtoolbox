function [dw_dqpr,dw_dqp,dw_dr] = ComputeDWDQPR(obj,dw_dxy)
  %COMPUTEDWDQPR Summary of this function goes here
  %   Detailed explanation goes here
  
  dw_dq = ComputeDWDQ(obj,dw_dxy);
  dw_dp = ComputeDWDP(obj,dw_dxy);
  
  dw_dqp = [dw_dq,dw_dp];
  
  dw_dr = ComputeDWDR(obj,dw_dxy);
  
  dw_dqpr = [dw_dqp,dw_dr];

end

