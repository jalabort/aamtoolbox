function [ann] = Shape2Ann(obj,shape)
  %SHAPE2ANN Summary of this function goes here
  %   Detailed explanation goes here

  ann = reshape(shape,obj.n_vert,2,[]);
  
end