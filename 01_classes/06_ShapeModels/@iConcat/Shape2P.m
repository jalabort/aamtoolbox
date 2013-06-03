function [p] = Shape2P(obj,shape)
  %Shape2P Summary of this function goes here
  %   Detailed explanation goes here

  p = obj.PU(1:obj.n_p,:) * (shape - obj.Ann2Shape(obj.mu_ann));
  
end



