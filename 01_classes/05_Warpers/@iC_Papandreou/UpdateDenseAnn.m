function [ann,p] = UpdateDenseAnn(~,sm,ann,delta,p)
  %UpdateDenseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  dWdp_uvi0 = sm.Compute_duvidp();
  dWdp_uvip = sm.Compute_duvidp_uvip(ann);
   
  Jp = (dWdp_uvip' * dWdp_uvip) \ dWdp_uvip' * dWdp_uvi0;
  
  p = p + Jp * delta;
  
  ann = sm.P2Ann(p);
  
end