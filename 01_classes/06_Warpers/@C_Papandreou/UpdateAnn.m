function [uann,p] = UpdateAnn(obj,sm,ann,delta,p)
  %UpdateAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  dWdp_u0 = sm.Compute_dudp();
  [dWdp_up,A] = sm.Compute_dWdp_up();

  dWdu_up = sm.Ann2Shape(obj.Compute_dWdu_up(A,ann)); 
  block_dWdu_p = repmat(dWdu_up(:,1),[1,sm.n_p]);
  block_dWdv_p = repmat(dWdu_up(:,2),[1,sm.n_p]); 
  
  dWdu_up_x_dWdp_u0 = block_dWdu_p .* dWdp_u0 + block_dWdv_p .* dWdp_u0;
   
  Jp = - (dWdp_up' * dWdp_up) \ dWdp_up' * dWdu_up_x_dWdp_u0;
  
  qpr = p + Jp * delta;
  
  [uann,p] = sm.P2Ann(qpr);
  
end