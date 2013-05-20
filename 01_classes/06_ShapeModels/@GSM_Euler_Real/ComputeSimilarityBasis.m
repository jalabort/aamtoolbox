function [sim_mu,sim_basis] = ComputeSimilarityBasis(obj)
  %ComputeSimilarityBasis Summary of this function goes here
  %   Detailed explanation goes here

  sim_mu = obj.Ann2Shape(obj.mu_ann);
  n_sim_basis = 4;
  sim_basis = zeros(2*obj.n_vert,n_sim_basis);
  
  one = ones(obj.n_vert,1);
  zero = zeros(obj.n_vert,1);

  sim_basis(:,1) = sim_mu;
  sim_basis(:,2) = [-obj.mu_ann(:,2);obj.mu_ann(:,1)];
  sim_basis(:,3) = [one;zero];
  sim_basis(:,4) = [zero;one];

end

