function [shape,p] = ProjectShape(obj,shape)
  %ProjectShape Summary of this function goes here
  %   Detailed explanation goes here

  p = obj.Shape2P(shape);
  shape = obj.P2Shape(p);

end

