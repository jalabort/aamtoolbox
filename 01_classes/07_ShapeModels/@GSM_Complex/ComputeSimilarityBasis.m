function [sim_mu,sim_basis] = ComputeSimilarityBasis(obj)
  %ComputeSimilarityBasis Summary of this function goes here
  %   Detailed explanation goes here

  sim_mu = obj.mu;
  n_sim_basis = 2;
  sim_basis = zeros(2*obj.n_vert,n_sim_basis);
  
  sim_basis(:,1) = sim_mu;
  sim_basis(:,2) = ones(2*obj.n_vert,1);

end

