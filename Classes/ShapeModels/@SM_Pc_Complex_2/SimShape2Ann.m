function [ann] = SimShape2Ann(obj,sShape)
  %SIMSHAPE2ANN Summary of this function goes here
  %   Detailed explanation goes here

  ann(:,1,:) = real(sShape);
  ann(:,2,:) = imag(sShape);
  
end