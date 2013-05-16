function [b] = Shape2B(obj,shape)
  %Shape2B Summary of this function goes here
  %   Detailed explanation goes here

  f = obj.Shape2F(shape);
  shape = obj.RemoveF(f,shape);
  
  r = obj.Shape2R(shape);
  
  b = [f;r];
  
end

