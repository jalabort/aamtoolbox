function [ann,p] = UpdateAnn(obj,sm,ann,delta,p)
  %UpdateAnnSummary of this function goes here
  %   Detailed explanation goes here
  
  pann = sm.P2Ann(delta);
  cann = obj.Compute_WoW(sm.mu_ann,pann,ann); 
  [ann] = sm.ProjectAnn(cann);
  
end

