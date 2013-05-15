function [p] = Shape2P(obj,shape)
  %Shape2P Summary of this function goes here
  %   Detailed explanation goes here

  q = obj.Shape2Q(shape);
  b = obj.Shape2B(obj.RemoveQ(q,shape));
  
  p = [q;b];
  
end



