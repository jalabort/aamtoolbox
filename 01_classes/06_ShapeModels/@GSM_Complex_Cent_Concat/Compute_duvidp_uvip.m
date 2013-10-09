function [duvidp_uvip] = Compute_duvidp_uvip(obj,~)
  %Compute_duvidp_uip Summary of this function goes here
  %   Detailed explanation goes here
  
  duvidp_uvip = Compute_duvidp_uvip@iConcat(obj);
  duvidp_uvip = obj.ComputeComplexDerivative(duvidp_uvip);
  
end

