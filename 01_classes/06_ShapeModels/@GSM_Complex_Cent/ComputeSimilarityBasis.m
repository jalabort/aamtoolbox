function [sim_mu,sim_basis] = ComputeSimilarityBasis(obj)
  %ComputeSimilarityBasis Summary of this function goes here
  %   Detailed explanation goes here

  sim_mu = obj.Ann2Shape(obj.mu_ann);
  n_sim_basis = 2;
  sim_basis = zeros(obj.n_vert,n_sim_basis);
  
  sim_basis(:,1) = sim_mu;
  sim_basis(:,2) = ones(obj.n_vert,1);

end

