function [dxy_dp] = GetDXYDP(obj)
  %GETDXYDP Summary of this function goes here
  %   Detailed explanation goes here

  dxy_dp = obj.MassShape2Shape(obj.mass_pc(:,1:obj.n_p));

end

