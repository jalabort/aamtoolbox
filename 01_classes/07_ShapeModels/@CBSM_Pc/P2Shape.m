function [m_shape] = P2Shape(obj,p)
  %P2SHAPE Summary of this function goes here
  %   Detailed explanation goes here

  m_shape = obj.pca.Coeff2Data(obj.mass_mu,obj.mass_pc,p);

end
