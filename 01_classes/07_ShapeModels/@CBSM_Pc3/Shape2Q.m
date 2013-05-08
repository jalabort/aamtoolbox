function [q] = Shape2Q(obj,shape)
  %SHAPE2Q Summary of this function goes here
  %   Detailed explanation goes here
  
  q = obj.sim_basis' * (obj.Shape2MassShape(shape) - obj.sim_mu);

end

