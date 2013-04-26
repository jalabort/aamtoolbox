function [qpr_ann,q,p,r] = UpdateAnn(obj,sm,ann,delta,q,p,r,~)
  %UPDATEANN Summary of this function goes here
  %   Detailed explanation goes here
  
  qpr_ann = sm.QPR2Ann(delta);
  
  cann = obj.ComposeWarp(qpr_ann,sm.mu_ann,ann); % ORIGINAL
%   cann = obj.ComposeWarp(sm.mu_ann,qpr_ann,ann);
   
  [qpr_ann] = sm.ProjectAnn(cann);
  
end

