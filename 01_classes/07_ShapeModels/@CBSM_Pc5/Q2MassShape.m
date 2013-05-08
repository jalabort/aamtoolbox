function [m_shape] = Q2MassShape(obj,q)
  %Q2MASSSHAPE Summary of this function goes here
  %   Detailed explanation goes here

  m_shape = obj.sim_mu + obj.sim_basis * q;
  
end

