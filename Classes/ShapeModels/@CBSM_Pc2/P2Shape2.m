function [m_shape] = P2Shape2(obj,p)
  %P2SHAPE2 Summary of this function goes here
  %   Detailed explanation goes here

  m_shape = obj.pca.Coeff2Data(zeros(size(obj.mass_mu)),obj.mass_pc,p);

end

