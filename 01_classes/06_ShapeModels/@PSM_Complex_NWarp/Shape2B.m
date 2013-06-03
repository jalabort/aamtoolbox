function [b] = Shape2B(obj,shape)
  %Shape2B Summary of this function goes here
  %   Detailed explanation goes here

  l = obj.Shape2L(shape);
  shape = obj.RemoveL(l,shape);

  f = obj.Shape2F(shape);
  shape = obj.RemoveF(f,shape);
  
  r = obj.Shape2R(shape);
  
  b = [l;f;r];
  
end

