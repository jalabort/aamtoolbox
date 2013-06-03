function [q] = Shape2Q(obj,shape)
  %Shape2Q Summary of this function goes here
  %   Detailed explanation goes here
  
  q = obj.sim_pca.Data2Coeff(obj.sim_mu,obj.sim_basis(:,1:obj.n_q),shape);
  
end

