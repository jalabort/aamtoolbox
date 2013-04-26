function [qpr_ann,q,p,r] = GetAnn(obj,qpr)
  %GETANN Summary of this function goes here
  %   Detailed explanation goes here

  q = qpr(1:obj.n_q);
  p = qpr(obj.n_q+1:end);
  r = [];
  
  p_shape = obj.P2Shape(p);

  [A,t] = obj.Q2MatForm(q);
  pr_ann = obj.Shape2Ann(p_shape);
  qpr_ann = obj.ApplyQ(pr_ann,A,t);
  
end



