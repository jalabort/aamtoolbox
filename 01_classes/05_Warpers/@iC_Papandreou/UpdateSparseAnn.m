function [ann,pk] = UpdateSparseAnn(obj,sm,ann,delta,p0,reg)
  %UpdateSparseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  dWdp_uvi0 = sm.Compute_duvidp();
  [dWdp_uvip,A] = sm.Compute_duvidp_uvip(p0);

  I = eye(2);
  dWduvi_uvip = sm.Ann2Shape(obj.Compute_dWduvi_uvip(I,ann)); 
  block_dWdui_p = repmat(dWduvi_uvip(:,1),[1,sm.n_p]);
  block_dWdvi_p = repmat(dWduvi_uvip(:,2),[1,sm.n_p]); 
  
  dWduvi_uvip_x_dWdp_uv0 = block_dWdui_p .* dWdp_uvi0 + block_dWdvi_p .* dWdp_uvi0;
   
  Jp = (dWdp_uvip' * dWdp_uvip) \ dWdp_uvip' * dWduvi_uvip_x_dWdp_uv0;
  
  pk = p0 + Jp * delta;
  %-----
  if reg == 1
    sigma_pk = inv(Jp * obj.sigma_inv_p * Jp);
    inv_sigma_p0 = inv(obj.sigma_p0); 
    inv_sigma_pk = inv(sigma_pk);
    sigma = inv(inv_sigma_p0 + inv_sigma_pk);
    pk = sigma * (inv_sigma_pk * pk + inv_sigma_p0 * p0);
    %obj.sigma_p0 = sigma;
  elseif reg == 2
    P = obj.sigma_p0 + obj.sigma_pk;
    K = P  / (P + inv(Jp * obj.sigma_inv_p * Jp));
    pk = p0 + K * (pk - p0);
    obj.sigma_pk = (eye(size(K)) - K) * P;
  end
  %-----
  ann = sm.P2Ann(pk);
  
end