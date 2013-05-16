function [shape] = Q2Shape(obj,q)
  %Q2Shape Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.pca.Coeff2Data(obj.sim_mu,obj.sim_basis(:,1:obj.n_q),q);
  
end

