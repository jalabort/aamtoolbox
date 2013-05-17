function [dWdp_uip] = Compute_dWdp_uip(obj,~)
  %Compute_dWdp_uip Summary of this function goes here
  %   Detailed explanation goes here
  
  dWdp_uip = Compute_dWdp_uip@Interface_Concat(obj);
  dWdp_uip = obj.ComputeComplexDerivative(dWdp_uip);
  
end

