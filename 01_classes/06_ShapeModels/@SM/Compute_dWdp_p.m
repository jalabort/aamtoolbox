function [dWdp_p,dWdq_p,dWdb_q] = Compute_dWdp_q(obj,dWduvi)
  %Compute_dWdp Summary of this function goes here
  %   Detailed explanation goes here
  
  [duidq_p,dvidq_p] = obj.Shape2UV(obj.Compute_duvidq());
  [duidb_p,dvidb_p] = obj.Shape2UV(obj.Compute_duvidb_q());
  
  dWdq_p = [dWduvi * duidq_p;dWduvi * dvidq_p]; 
  dWdb_p = [dWduvi * duidb_p;dWduvi * dvidb_p];
  
  dWdp_p = [dWdq_p,dWdb_p];
  
end

