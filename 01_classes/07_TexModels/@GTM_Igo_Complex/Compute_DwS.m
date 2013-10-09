function [tex] = Compute_DwS(obj,tex)
  %Compute_DwS Summary of this function goes here
  %   Detailed explanation goes here

  tex = obj.pc(:,2:obj.n_c) * diag(1./obj.ev(2:obj.n_c)) * ...
    (obj.pc(:,2:obj.n_c)' * tex);
  
end

