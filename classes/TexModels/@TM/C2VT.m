function [dt_dx,dt_dy] = C2VT(obj,c)
  %C2VT Summary of this function goes here
  %   Detailed explanation goes here
  
  dt_dx = obj.dt_dx(:,1:length(c)) * c;
  dt_dy = obj.dt_dy(:,1:length(c)) * c;

end

