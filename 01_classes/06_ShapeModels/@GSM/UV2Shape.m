function [shape] = UV2Shape(obj,u,v)
  %UV2Shape Summary of this function goes here
  %   Detailed explanation goes here
  
  ann(:,1,:) = u;
  ann(:,2,:) = v;
  
  shape = obj.Ann2Shape(ann);

end

