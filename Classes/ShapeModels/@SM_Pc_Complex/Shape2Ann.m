function [ann] = Shape2Ann(~,shape)
  %SHAPE2ANN Summary of this function goes here
  %   Detailed explanation goes here

  ann(:,1,:) = real(shape);
  ann(:,2,:) = imag(shape);
  
end