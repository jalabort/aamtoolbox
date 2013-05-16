function [f] = Shape2F(obj,shape)
  %Shape2F Summary of this function goes here
  %   Detailed explanation goes here

  f = obj.pca.Data2Coeff(obj.mass_mu,obj.mass_pc,shape);
  
end

