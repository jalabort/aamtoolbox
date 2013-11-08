function [tex] = Compute_DwS(obj,tex)
  %Compute_DwS Summary of this function goes here
  %   Detailed explanation goes here

  tex = obj.pc(:,1:obj.n_c) * (diag(1./(obj.ev(1:obj.n_c) + obj.variance)) * ...
    (obj.pc(:,1:obj.n_c)' * tex));
  
end


