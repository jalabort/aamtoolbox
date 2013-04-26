function [qpAnn,q,p] = ProjectAnn(obj,ann,nShapes,reg,n)
  %PROJECTANN Summary of this function goes here
  %   Detailed explanation goes here

  sShape = obj.Ann2SimShape(ann);
  q = obj.SimShape2Q(sShape);
  [A,t] = obj.Q2MatForm(q);
  rsAnn = obj.RemoveSim(ann,A,t);
    
  rsShape = obj.Ann2Shape(rsAnn);
  p = obj.Shape2P(rsShape);
  p = p (1:nShapes);
  pShape = obj.P2Shape(p);
  pAnn = obj.Shape2Ann(pShape);
%   pAnn = obj.Shape2Ann(obj.simMU);
%   p = [];
  
  qpAnn = obj.ApplySim(pAnn,A,t);
  
end



