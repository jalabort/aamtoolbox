function [duvidq] = Compute_duvidq(obj)
  %Compute_duvidq Summary of this function goes here
  %   Detailed explanation goes here

  duvidq = obj.sim_basis(:,1:obj.n_q);

end

