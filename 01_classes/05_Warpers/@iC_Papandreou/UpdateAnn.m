function [ann,p] = UpdateAnn(obj,sm,ann,delta,p)
  %UpdateAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  dWdp_uv0 = sm.Compute_dudp();
  [dWdp_uvp,A] = sm.Compute_dWdp_up(ann);

  dWduvi_uvip = sm.Ann2Shape(obj.Compute_dWduvi_uvip(A,ann)); 
  block_dWdui_p = repmat(dWduvi_uvip(:,1),[1,sm.n_p]);
  block_dWdvi_p = repmat(dWduvi_uvip(:,2),[1,sm.n_p]); 
  
  dWduvi_uvip_x_dWdp_uv0 = block_dWdui_p .* dWdp_uv0 + block_dWdvi_p .* dWdp_uv0;
   
  Jp = - (dWdp_uvp' * dWdp_uvp) \ dWdp_uvp' * dWduvi_uvip_x_dWdp_uv0;
  
  p = p + Jp * delta;
  
  [ann,p] = sm.P2Ann(p);
  
end