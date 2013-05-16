function [duidf] = Compute_duidf(obj)
  %Compute_duidf Summary of this function goes here
  %   Detailed explanation goes here

  duidf = obj.mass_pc(:,1:obj.n_f);

end

