function [A,t] = Q2MatForm(obj,q)
  %OBJ2MATFORM Summary of this function goes here
  %   Detailed explanation goes here

  qShape = obj.Q2SimShape(q);
  qAnn = obj.SimShape2Ann(qShape);
  [A,t] = obj.ComputeSimMatForm(qAnn); 

end

