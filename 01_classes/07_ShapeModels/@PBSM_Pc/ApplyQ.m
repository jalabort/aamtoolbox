function [q_shape] = ApplyQ(obj,shape,q)
  %APPLYQ Summary of this function goes here
  %   Detailed explanation goes here

  q_shape = shape + obj.Q2Shape(q) - obj.sim_mu;

end

