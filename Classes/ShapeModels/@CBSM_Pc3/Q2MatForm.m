function [A,t] = Q2MatForm(obj,q)
  %Q2MATFORM Summary of this function goes here
  %   Detailed explanation goes here

  q_shape = obj.Q2MassShape(q);
  q_ann = obj.Shape2Ann(q_shape);
  [A,t] = obj.ComputeSimMatForm(q_ann); 

end

