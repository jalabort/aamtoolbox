function [dAdc] = Compute_dAdc(obj)
  %Compute_dAdc Summary of this function goes here
  %   Detailed explanation goes here

  dAdc = obj.pc(:,1:obj.n_c);

end

