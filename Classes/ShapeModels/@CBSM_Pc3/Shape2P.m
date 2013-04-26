function [p] = Shape2P(obj,shape)
  %SHAPE2P Summary of this function goes here
  %   Detailed explanation goes here
  
  [p] = obj.pca.Data2Coeff(obj.mass_mu,obj.mass_pc(:,1:obj.n_p),obj.Shape2MassShape(shape));

end

