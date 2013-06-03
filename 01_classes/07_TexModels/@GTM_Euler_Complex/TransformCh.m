function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  dir = img(obj.mask1) * obj.alpha_pi;
  nx = cos(dir);
  ny = sin(dir);
  tex = (nx + 1j*ny) / sqrt(obj.n_face_pixels1);
  
end

