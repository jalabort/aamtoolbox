function [shape] = UV2Shape(obj,u,v)
  %UV2Shape Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = obj.Ann2Shape([u,v]);

end

