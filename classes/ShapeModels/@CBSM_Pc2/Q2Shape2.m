function [m_shape] = Q2Shape2(obj,q)
  %Q2SHAPE2 Summary of this function goes here
  %   Detailed explanation goes here

  m_shape = obj.sim_basis * q;
  
end

