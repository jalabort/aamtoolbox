function [dWdp_uip] = Compute_dWdp_uip(obj,p)
  %Compute_dWdp Summary of this function goes here
  %   Detailed explanation goes here
  
  q = p(1:n_q);
  
  duidq = obj.Compute_duidq();
  duidb_q = obj.Compute_duidb_q(q);
  
  dWdp_uip = [duidq;duidb_q];
  
end

