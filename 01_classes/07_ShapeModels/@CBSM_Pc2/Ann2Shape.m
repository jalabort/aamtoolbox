function [shape] = Ann2Shape(~,ann)
  %ANN2SHAPE Summary of this function goes here
  %   Detailed explanation goes here
  
  n_vert = size(ann,1);
  shape = reshape(ann,2*n_vert,[]);

end

