function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  [gx,gy] = gradient(img);
  gdir = angle(gx + 1j*gy);
  ngx = cos(gdir);
  ngy = sin(gdir);
  tex = [ngx(obj.mask1);ngy(obj.mask1)] ./ sqrt(obj.n_face_pixels1);
  
end

