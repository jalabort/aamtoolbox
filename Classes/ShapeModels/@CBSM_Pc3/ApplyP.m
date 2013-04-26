function [pr_shape] = ApplyP(obj,r_shape,p_m_shape)
  %APPLYP Summary of this function goes here
  %   Detailed explanation goes here

  pr_shape = r_shape + obj.MassShape2Shape(p_m_shape);

end

