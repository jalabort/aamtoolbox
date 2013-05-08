function [qpr_ann,q,p,r] = ProjectAnn(obj,ann)
  %PROJECTANN Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.Ann2Shape(ann);
  qpr = obj.P * shape;
  [qpr_ann,q,p,r] = obj.GetAnn(qpr);
  
end



