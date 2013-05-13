function [uann,p] = UpdateAnn(obj,sm,ann,delta,p)
  %UpdateAnnSummary of this function goes here
  %   Detailed explanation goes here
  
  uann = sm.P2Ann(delta);
  cann = obj.Compute_WoW(uann,sm.mu_ann,ann); 
  [uann] = sm.ProjectAnn(cann);
  
end

