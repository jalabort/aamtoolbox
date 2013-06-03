function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  [gx,gy] = gradient(img);
  gdir = angle(gx(obj.mask1) + 1j*gy(obj.mask1));
  ngx = cos(gdir);
  ngy = sin(gdir);
  tex = (ngx + 1j*ngy) / sqrt(obj.n_face_pixels1);
  
end

