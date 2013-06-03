function [sim_mu,sim_basis] = ComputeSimilarityBasis(obj)
  %ComputeSimilarityBasis Summary of this function goes here
  %   Detailed explanation goes here

  sim_mu = obj.pc(:,1);
  sim_basis = ones(obj.n_vert,1);

end

