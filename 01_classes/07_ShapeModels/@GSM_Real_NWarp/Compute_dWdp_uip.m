function [dWdp_uip] = Compute_dWdp_uip(obj,p)
  %Compute_dWdp Summary of this function goes here
  %   Detailed explanation goes here
  
  q = p(1:n_q);
  
  duidq = obj.Compute_duidq();
  rot_duidb = obj.Rotate_duidb(q);
  
  dWdp_uip = [duidq;rot_duidb];
  
end

