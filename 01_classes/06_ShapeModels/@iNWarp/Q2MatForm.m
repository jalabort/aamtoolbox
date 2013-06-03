function [A,t] = Q2MatForm(obj,q)
  %Q2MatFormSummary of this function goes here
  %   Detailed explanation goes here

  shape = obj.Q2Shape(q);
  ann = obj.Shape2Ann(shape);
  [A,t] = obj.ComputeSimilarityMatrixForm(ann); 

end

