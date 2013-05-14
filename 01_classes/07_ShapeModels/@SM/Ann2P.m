function [p] = Ann2P(obj,ann)
  %Ann2P Summary of this function goes here
  %   Detailed explanation goes here

  p = obj.Shape2P(obj.Ann2Shape(ann));

end

