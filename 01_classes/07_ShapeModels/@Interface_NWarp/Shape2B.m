function [b] = Shape2B(obj,shape)
  %Shape2B Summary of this function goes here
  %   Detailed explanation goes here

  b = obj.pca.Data2Coeff(obj.mu,obj.pc(:,1:obj.n_b),shape);

end

