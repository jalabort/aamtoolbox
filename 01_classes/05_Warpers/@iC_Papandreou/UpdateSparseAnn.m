function [ann,p] = UpdateSparseAnn(obj,sm,ann,delta,p)
  %UpdateSparseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  dWdp_uvi0 = sm.Compute_duvidp();
  [dWdp_uvip,A] = sm.Compute_duvidp_uvip(p);

  I = eye(2);
  dWduvi_uvip = sm.Ann2Shape(obj.Compute_dWduvi_uvip(I,ann)); 
  block_dWdui_p = repmat(dWduvi_uvip(:,1),[1,sm.n_p]);
  block_dWdvi_p = repmat(dWduvi_uvip(:,2),[1,sm.n_p]); 
  
  dWduvi_uvip_x_dWdp_uv0 = block_dWdui_p .* dWdp_uvi0 + block_dWdvi_p .* dWdp_uvi0;
   
  Jp = (dWdp_uvip' * dWdp_uvip) \ dWdp_uvip' * dWduvi_uvip_x_dWdp_uv0;
  
  p = p + Jp * delta;
  
  ann = sm.P2Ann(p);
  
end