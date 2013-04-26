function [sim_mu,sim_basis,n_sim_basis,pc] = ComputeGlobalSimBasis(obj)
  %COMPUTESIMILARITYBASIS Summary of this function goes here
  %   Detailed explanation goes here

  sim_mu = obj.mu;
  n_sim_basis = 2;
  sim_basis = zeros(obj.n_vert,n_sim_basis);

  sim_basis(:,1) = sim_mu;
  sim_basis(:,2) = ones(obj.n_vert,1);

  [Q,~] = qr([sim_basis,obj.pc],0);
  sim_basis = Q(:,1:n_sim_basis);
  limit = min(n_sim_basis+obj.n_pc,size(Q,1));
  pc = Q(:,n_sim_basis+1:limit);

end

