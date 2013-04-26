function [r_shape] = RemoveP(obj,pr_shape,p_m_shape)
  %REMOVEP Summary of this function goes here
  %   Detailed explanation goes here

  r_shape = pr_shape - obj.MassShape2Shape(p_m_shape);
  
end

