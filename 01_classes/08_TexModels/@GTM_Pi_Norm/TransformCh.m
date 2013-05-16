function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  tex = img(obj.mask1) - mean(img(obj.mask1));
  tex = tex ./ norm(tex);
  
end

