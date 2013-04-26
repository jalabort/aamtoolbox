function [ann] = Shape2Ann(~,shape)
  %SHAPE2ANN Summary of this function goes here
  %   Detailed explanation goes here

  n_vert = size(shape,1) / 2;
  ann = reshape(shape,n_vert,2,[]);
  
end