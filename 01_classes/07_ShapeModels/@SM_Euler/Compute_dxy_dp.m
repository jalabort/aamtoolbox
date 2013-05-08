function [dx_dp,dy_dp] = Compute_dxy_dp(obj,nShapes)
  %COMPUTE_DXY_DP Summary of this function goes here
  %   Detailed explanation goes here

  dxy_dp = imag(1 ./ (obj.alphaPi * obj.PC(:,1:nShapes)));
  [dx_dp,dy_dp] = obj.SimShape2XY(dxy_dp);

end

