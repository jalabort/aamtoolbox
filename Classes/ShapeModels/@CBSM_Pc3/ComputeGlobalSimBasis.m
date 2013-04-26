function [sim_mu,sim_basis,n_sim_basis,mass_pc] = ComputeGlobalSimBasis(obj)
  %COMPUTEGLOBALSIMILARITYBASIS Summary of this function goes here
  %   Detailed explanation goes here

  sim_mu = obj.mass_mu;
  n_sim_basis = 4;
  sim_basis = zeros(2*obj.n_comp,n_sim_basis);
  
  [sim_mu_x,sim_mu_y] = obj.Shape2XY(sim_mu);
  one = ones(obj.n_comp,1);
  zero = zeros(obj.n_comp,1);

  sim_basis(:,1) = sim_mu;
  sim_basis(:,2) = [-sim_mu_y;sim_mu_x];
  sim_basis(:,3) = [one;zero];
  sim_basis(:,4) = [zero;one];

  [Q,~] = qr([sim_basis,obj.mass_pc],0);
  sim_basis = Q(:,1:n_sim_basis);
  limit = min(n_sim_basis+obj.n_mass_pc,size(Q,1));
  mass_pc = Q(:,n_sim_basis+1:limit);

end

