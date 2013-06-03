function [c] = Tex2C(obj,tex)
  %Tex2C Summary of this function goes here
  %   Detailed explanation goes here

  c = obj.pca.Data2Coeff(obj.mu,obj.pc(:,1:obj.n_c),tex);

end

