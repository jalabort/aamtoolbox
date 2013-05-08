function [sShape] = Coeff2SimShape(obj,coeff)
  %COEFF2SIMSHAPE Summary of this function goes here
  %   Detailed explanation goes here

  sShape = obj.simBasis(:,1) + obj.simBasis(:,1:length(coeff)) * coeff;
  
end

