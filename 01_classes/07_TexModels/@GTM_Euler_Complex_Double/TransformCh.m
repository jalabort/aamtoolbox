function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  dir = img(obj.mask1) * obj.alpha_pi;
  dir2 = 2*dir;
  nx = cos(dir);
  ny = sin(dir);
  nx2 = cos(dir2);
  ny2 = sin(dir2);
  tex = [nx + 1j*ny;nx2 + 1j*ny2] / (2*obj.n_face_pixels1).^(1/2);
  
end

