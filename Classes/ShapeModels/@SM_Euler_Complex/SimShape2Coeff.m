function [coeff] = SimShape2Coeff(obj,sShape)
  %SIMSHAPE2COEFF Summary of this function goes here
  %   Detailed explanation goes here
  
  coeff = obj.simBasis' * (sShape - obj.simBasis(:,1));

end

