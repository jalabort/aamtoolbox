function [dxy_dq] = GetDXYDQ(obj)
  %GETDXYDQ Summary of this function goes here
  %   Detailed explanation goes here

  dxy_dq = obj.MassShape2Shape(obj.sim_basis);

end

