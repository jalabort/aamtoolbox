function [shape] = P2Shape(obj,p)
  %Shape2P Summary of this function goes here
  %   Detailed explanation goes here

  shape =  obj.mu + obj.U * p;
  
end



