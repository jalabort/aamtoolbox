function [shape] = P2Shape(obj,p)
  %Shape2P Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.Ann2Shape(obj.mu_ann) + obj.U(:,1:obj.n_p) * p;
  
end



