function [sim_basis] = OrthonormalizeBasis(obj)
%OrthonormalizeBasis Summary of this function goes here
%   Detailed explanation goes here

  [Q,~] = qr(obj.sim_basis,0);
  sim_basis = Q(:,1:obj.n_sim_basis);

end

