function [dWdp_p,dWdq_p,dWdb_p] = Compute_dWdp_p(obj,dWduvi,p)
  %Compute_dWdp_p Summary of this function goes here
  %   Detailed explanation goes here
  
  [duidp_p,dvidp_p] = obj.Shape2UV(obj.Compute_duvidp_uvip(p));
  
  dWdp_p = [dWduvi * duidp_p;dWduvi * dvidp_p]; 
  dWdq_p = dWdp_p(:,1:obj.n_q);
  dWdb_p = dWdp_p(:,obj.n_q+1:end);
  
end

