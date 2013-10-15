function [ann,pk] = UpdateDenseAnn(obj,sm,ann,delta,p0,reg)
  %UpdateDenseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  dWdp_uvi0 = sm.Compute_duvidp();
  dWdp_uvip = sm.Compute_duvidp_uvip(ann);
   
  Jp = (dWdp_uvip' * dWdp_uvip) \ dWdp_uvip' * dWdp_uvi0;
  
  pk = p0 + Jp * delta;
  %-----
  if reg == 1
    inv_sigma_pk = inv(Jp * obj.sigma_inv_p * Jp);
    inv_sigma = obj.inv_sigma_p0 + inv_sigma_pk;
    pk = inv_sigma \ (inv_sigma_pk * pk + obj.inv_sigma_p0 * p0);
    obj.inv_sigma_p0 = inv_sigma;
  elseif reg == 2
    P = obj.sigma_p0 + obj.sigma_pk;
    K = P  / (P + Jp * obj.sigma_inv_p * Jp);
    pk = p0 + K * (pk - p0);
    obj.sigma_pk = (eye(size(K)) - K) * P;
  end
  %-----
  ann = sm.P2Ann(pk);
  
end