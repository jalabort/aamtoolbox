function [dT_dx,dT_dy] = Compute_dT_dX(obj,nTexs)
%COMPUTE_DT_DX Summary of this function goes here
%   Detailed explanation goes here

  dT_dx = zeros(obj.nCh*obj.nFacePixels,nTexs);
  dT_dy = zeros(obj.nCh*obj.nFacePixels,nTexs);
 
  for i = 1:nTexs
    [dT_dx(:,i),dT_dy(:,i)] = obj.Compute_dt_dxy(obj.PC(:,i)); 
  end
  
end

