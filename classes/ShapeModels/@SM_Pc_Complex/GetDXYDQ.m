function [dxy_dq] = GetDXYDQ(obj)
  %GETDXYDQ Summary of this function goes here
  %   Detailed explanation goes here

  [dx_dq,dy_dq] = obj.ComputeDXYDQ();
  
  dxy_dq = dx_dq + dy_dq;

end

