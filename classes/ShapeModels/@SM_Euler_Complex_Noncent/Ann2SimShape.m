function [sShape] = Ann2SimShape(obj,ann)
  %ANN2SIMSHAPE Summary of this function goes here
  %   Detailed explanation goes here
  
  sShape = reshape(ann,2*obj.nVert,[]);

end

