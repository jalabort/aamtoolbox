function [q] = SimShape2Q(obj,sShape)
  %SIMSHAPE2Q Summary of this function goes here
  %   Detailed explanation goes here
  
  q = obj.simBasis' * (sShape - obj.simMU);

end

