function [dxy_dpr] = GetDXYDPR(obj)
  %GETDXYDPR Summary of this function goes here
  %   Detailed explanation goes here

  dxy_dp = obj.GetDXYDP();
  dxy_dr = obj.GetDXYDR();
  
  dxy_dpr = [dxy_dp,dxy_dr];

end

