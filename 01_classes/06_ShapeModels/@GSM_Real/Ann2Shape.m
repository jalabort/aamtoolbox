function [shape] = Ann2Shape(obj,ann)
  %Ann2Shape Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = reshape(ann,2*obj.n_vert,[]);

end

