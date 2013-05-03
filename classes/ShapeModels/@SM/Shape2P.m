function [p] = Shape2P(obj,shape)
  %SHAPE2P Summary of this function goes here
  %   Detailed explanation goes here

  [p] = obj.pca.Data2Coeff(obj.mu,obj.pc(:,1:obj.n_p),shape);

end

