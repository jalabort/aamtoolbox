function [shape] = ApplyF(obj,f,shape)
  %ApplyF Summary of this function goes here
  %   Detailed explanation goes here

  shape = shape + obj.F2Shape(f);

end

