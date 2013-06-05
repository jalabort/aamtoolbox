function [ann,p] = UpdateDenseAnn(obj,sm,ann,delta,p)
  %UpdateDenseAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  pann = sm.P2Ann(delta);
  
  q = p(1:4);
  
  
  
  cann = sm.Shape2Ann(sm.ApplyQ(q,sm.Ann2Shape(pann) + sm.pc(:,1:sm.n_b) * p(5:end)));
   
  [ann,p] = sm.ProjectAnn(cann);
  
end

