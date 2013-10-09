function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  [gx,gy] = gradient(img);
  gdir = angle(gx(obj.mask1) + 1j*gy(obj.mask1));
  gdir2 = 2 * gdir;
  ngx = cos(gdir);
  ngy = sin(gdir);
  ngx2 = cos(gdir2);
  ngy2 = sin(gdir2);
  tex = [ngx + 1j*ngy;ngx2 + 1j*ngy2] / (2*obj.n_face_pixels1).^(1/2);
  
end

