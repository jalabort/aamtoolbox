function [ann] = Shape2Ann(~,shape)
  %Shape2Ann Summary of this function goes here
  %   Detailed explanation goes here

  ann(:,1,:) = real(shape);
  ann(:,2,:) = imag(shape);
  
end