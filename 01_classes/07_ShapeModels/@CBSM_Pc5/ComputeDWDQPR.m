function [dw_dqpr,dw_dq,dw_dpr] = ComputeDWDQPR(obj,dw_dxy)
  %COMPUTEDWDQPR Summary of this function goes here
  %   Detailed explanation goes here
  
  dw_dq = ComputeDWDQ(obj,dw_dxy);
  dw_dp = ComputeDWDP(obj,dw_dxy);
  dw_dr = ComputeDWDR(obj,dw_dxy);
  
  dw_dpr = [dw_dp,dw_dr];
  dw_dqpr = [dw_dq,dw_dpr];

end

