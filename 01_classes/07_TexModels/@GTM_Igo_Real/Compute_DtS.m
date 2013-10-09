function [tex] = Compute_DtS(obj,tex)
  %Compute_DtS Summary of this function goes here
  %   Detailed explanation goes here

  tex = (1 / obj.variance) * ...
    (tex - ...
    obj.pc(:,1:obj.n_c) * (obj.pc(:,1:obj.n_c)' * tex));

end

