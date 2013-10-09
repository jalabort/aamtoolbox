function [sim_basis] = GetSimBasis(obj)
  %GetSimBasis Summary of this function goes here
  %   Detailed explanation goes here
  
  sim_basis = obj.sim_basis(:,1:obj.n_q);
  
end

