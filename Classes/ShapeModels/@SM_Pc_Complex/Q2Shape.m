function [shape] = Q2Shape(obj,q)
  %q2SHAPE Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.sim_mu + obj.sim_basis(:,1:length(q)) * q;
  
end

