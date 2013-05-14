function [duidq] = Compute_duidq(obj)
  %Compute_duidq Summary of this function goes here
  %   Detailed explanation goes here

  duidq = obj.sim_basis(:,1:obj.n_q);

end

