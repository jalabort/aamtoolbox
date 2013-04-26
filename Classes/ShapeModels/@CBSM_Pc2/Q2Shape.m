function [m_shape] = Q2Shape(obj,q)
  %Q2SHAPE Summary of this function goes here
  %   Detailed explanation goes here

  m_shape = obj.sim_mu + obj.sim_basis * q;
  
end

