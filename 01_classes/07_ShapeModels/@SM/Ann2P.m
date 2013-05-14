function [p] = Ann2P(obj,ann)
  %Ann2P Summary of this function goes here
  %   Detailed explanation goes here

  p = obj.P2Shape(obj.Ann2Shape(ann));

end

