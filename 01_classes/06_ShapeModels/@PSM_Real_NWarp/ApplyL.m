function [shape] = ApplyL(obj,l,shape)
  %ApplyL Summary of this function goes here
  %   Detailed explanation goes here

  shape = shape + obj.L2Shape(l) - obj.pose_mu;

end

