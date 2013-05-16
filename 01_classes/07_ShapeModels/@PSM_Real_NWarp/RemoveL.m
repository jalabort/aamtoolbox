function [shape] = RemoveL(obj,l,shape)
  %RemoveL Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = shape - obj.L2Shape(l) + obj.pose_mu;
  
end

