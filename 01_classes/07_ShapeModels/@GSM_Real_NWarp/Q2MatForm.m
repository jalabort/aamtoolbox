function [A,t] = Q2MatForm(obj,q)
  %OBJ2MATFORM Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.Q2Shape(q);
  ann = obj.Shape2Ann(shape);
  [A,t] = obj.ComputeSimilarityMarixtForm(ann); 

end

