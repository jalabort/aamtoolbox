function [pr_shape] = RemoveQ(obj,shape,q)
  %REMOVEQ Summary of this function goes here
  %   Detailed explanation goes here

  pr_shape = shape - obj.Q2Shape(q) + obj.sim_mu;

end

