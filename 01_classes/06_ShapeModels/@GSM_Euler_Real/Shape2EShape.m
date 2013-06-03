function [eshape] = Shape2EShape(obj,shape)
  %Shape2EShape Summary of this function goes here
  %   Detailed explanation goes here
    
  dir = obj.alpha_pi * shape;
  nx = cos(dir);
  ny = sin(dir);
  eshape = [nx;ny];

end

