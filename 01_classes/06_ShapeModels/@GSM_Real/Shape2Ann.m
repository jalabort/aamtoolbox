function [ann] = Shape2Ann(obj,shape)
  %Shape2Ann Summary of this function goes here
  %   Detailed explanation goes here

  ann = reshape(shape,obj.n_vert,2,[]);
  
end