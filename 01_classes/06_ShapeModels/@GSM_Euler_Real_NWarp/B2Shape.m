function [shape] = B2Shape(obj,b)
  %B2Shape Summary of this function goes here
  %   Detailed explanation goes here

  eshape = B2Shape@Interface_NWarp(obj,b);
  shape = obj.EShape2Shape(eshape);

end

