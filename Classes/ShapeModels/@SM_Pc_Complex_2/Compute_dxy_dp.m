function [dx_dp,dy_dp] = Compute_dxy_dp(obj,nShapes)
  %COMPUTE_DXY_DP Summary of this function goes here
  %   Detailed explanation goes here
  
  U1 = obj.PC(:,1:nShapes);
  [auxX1,auxY1] = obj.Shape2XY(U1);
  dx_dp1 = 0.5 * (auxX1 + 1i*auxY1);
  dy_dp1 = 0.5 * (auxY1 - 1i*auxX1);
  
  U2 = obj.PC(:,1+end/2:end/2+nShapes);
  [auxX2,auxY2] = obj.Shape2XY(U2);
  dx_dp2 = 0.5 * (auxX2 + 1i*auxY2);
  dy_dp2 = 0.5 * (auxY2 - 1i*auxX2);
  
  dx_dp = dx_dp1 + dx_dp2;
  dy_dp = dy_dp1 + dy_dp2;
  
  
end

