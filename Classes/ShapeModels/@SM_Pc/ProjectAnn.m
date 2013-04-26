function [qp_ann,q,p,r] = ProjectAnn(obj,ann)
  %PROJECTANN Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.Ann2Shape(ann);
  q = obj.Shape2Q(shape);
  [A,t] = obj.Q2MatForm(q);
  p_ann = obj.RemoveQ(ann,A,t);
    
  p_shape = obj.Ann2Shape(p_ann);
  p = obj.Shape2P(p_shape);
  p_shape = obj.P2Shape(p);
 
  p_ann = obj.Shape2Ann(p_shape);
  qp_ann = obj.ApplyQ(p_ann,A,t);
  
  r = [];
  
end



