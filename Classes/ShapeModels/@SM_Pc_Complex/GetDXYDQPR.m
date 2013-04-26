function [dxy_dqpr] = GetDXYDQPR(obj)
  %GETDXYDQPR Summary of this function goes here
  %   Detailed explanation goes here

  dxy_dq = obj.GetDXYDQ();
  dxy_dpr = obj.GetDXYDPR();
  
  dxy_dqpr = [dxy_dq,dxy_dpr];

end

