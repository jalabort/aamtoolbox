function [comp_pc,comp_ev,n_comp_pc] = ComputeScaleBase(obj,i)
  %COMPUTESCALEBASE Summary of this function goes here
  %   Detailed explanation goes here

  n_comp_pc = obj.n_comp_pc{i} + 1;
  sim_mu = obj.comp_mu{i};
  [Q,~] = qr([sim_mu,obj.comp_pc{i}],0);
  comp_pc = Q(:,1:n_comp_pc);
  comp_ev = [0,obj.comp_ev{i}];
    
end

