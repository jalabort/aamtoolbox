function [dt_dx,dt_dy] = Coeff2VTex(obj,coeff)
  %COEFF2VTEX Summary of this function goes here
  %   Detailed explanation goes here
  
  dt_dx = obj.dT_dx(:,1:length(coeff)) * coeff;
  dt_dy = obj.dT_dy(:,1:length(coeff)) * coeff;

end

