function [b] = Shape2B(obj,shape)
  %Shape2B Summary of this function goes here
  %   Detailed explanation goes here
  
  eshape = obj.Shape2EShape(shape);
  b = Shape2B@Interface_NWarp(obj,eshape);

end

