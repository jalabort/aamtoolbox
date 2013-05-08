function [m_shape] = P2MassShape(obj,p)
  %P2MASSSHAPE Summary of this function goes here
  %   Detailed explanation goes here

  m_shape = obj.pca.Coeff2Data(obj.mass_mu,obj.mass_pc,p);

end

