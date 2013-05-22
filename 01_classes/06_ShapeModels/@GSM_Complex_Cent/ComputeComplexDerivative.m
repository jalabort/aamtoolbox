function [dxdp] = ComputeComplexDerivative(obj,dxdp)
%ComputeComplexDerivative Summary of this function goes here
%   Detailed explanation goes here

  [uaux,vaux] = obj.Shape2UV(dxdp);
  
  % complex derivative
  dxdp = 0.5 * (uaux + 1i*vaux);
  dydp = 0.5 * (vaux - 1i*uaux);
  
  dxdp = obj.UV2Shape(dxdp,dydp);

end

