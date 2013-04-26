function [dxy_dp] = GetDXYDP(obj)
  %GETDXYDP Summary of this function goes here
  %   Detailed explanation goes here

  [dx_dp,dy_dp] = obj.ComputeDXYDP();
  
  dxy_dp = dx_dp + dy_dp;

end

