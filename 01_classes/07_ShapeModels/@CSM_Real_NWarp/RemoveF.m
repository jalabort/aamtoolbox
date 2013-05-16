function [shape] = RemoveF(obj,f,shape)
  %RemoveF Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = shape - obj.F2Shape(f) + obj.mass_mu;
  
end

