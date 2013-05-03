function [qp_ann,q,p,r] = ProjectAnn(obj,ann)
  %PROJECTANN Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.Ann2Shape(ann);
  A = obj.GetDXYDQPR();
  qpr_shape =  A * ((A' * A) \ A' * shape);
  qp_ann = obj.Shape2Ann(qpr_shape);
  q = [];
  p = [];
  r = [];
  
end



