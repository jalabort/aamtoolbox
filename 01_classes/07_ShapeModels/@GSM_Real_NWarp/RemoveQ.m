function [shape,ann] = RemoveQ(obj,q,shape)
  %RemoveQ Summary of this function goes here
  %   Detailed explanation goes here

  ann = obj.Shape2Ann(shape);
  [A,t] = obj.Q2MatForm(q);
  ann = (ann - repmat(t,[obj.n_vert,1])) / A;
  shape = obj.Ann2Shape(ann);

end

