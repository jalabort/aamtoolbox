function [ann,p] = UpdateAnn(obj,sm,ann,delta,~)
  %UpdateAnnSummary of this function goes here
  %   Detailed explanation goes here
  
  pann = sm.P2Ann(delta);
  cann = obj.Compute_WoW(sm.mu_ann,pann,ann); 
  [ann,p] = sm.ProjectAnn(cann);
  
end

