function [qpr_ann,q,p,r] = ProjectAnn(obj,ann)
  %PROJECTANN Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.Ann2Shape(ann);
  q = obj.Shape2Q(shape);
  [A,t] = obj.Q2MatForm(q);
  pr_ann = obj.RemoveQ(ann,A,t);
    
  pr_shape = obj.Ann2Shape(pr_ann);
  p = obj.Shape2P(pr_shape);
  p_shape = obj.P2Shape(p);
  r_shape = obj.RemoveP(pr_shape,p_shape);
  
  r = obj.Shape2R(r_shape);
  r_shape = obj.R2Shape(r);
  
  pr_shape = obj.ApplyP(r_shape,p_shape);
  pr_ann = obj.Shape2Ann(pr_shape);
  qpr_ann = obj.ApplyQ(pr_ann,A,t);
  
end



