function [duvidf] = Compute_duvidf(obj)
  %Compute_duvidf Summary of this function goes here
  %   Detailed explanation goes here

  duvidf = obj.mass_pc(:,1:obj.n_f);

end

