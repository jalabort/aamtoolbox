function [A,t] = Q2MatForm(obj,q)
  %Q2MatFormSummary of this function goes here
  %   Detailed explanation goes here

  aux = obj.n_p;
  obj.n_p = obj.n_q;
  shape = obj.P2Shape(q);
  obj.n_p = aux;
  ann = obj.Shape2Ann(shape);
  [A,t] = obj.ComputeSimilarityMatrixForm(ann); 

end

