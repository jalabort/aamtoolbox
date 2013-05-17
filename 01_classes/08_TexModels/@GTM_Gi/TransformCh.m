function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  [gx,gy] = gradient(img);
  aux = gx(obj.mask1) + 1i*gy(obj.mask1);
  gmag = abs(aux);
  n = gmag + median(gmag);
  ngx = gx(obj.mask1) ./ n;
  ngy = gy(obj.mask1) ./ n;
  tex = [ngx;ngy];
  
%   tex(isnan(tex)) = 0;
%   tex(isinf(tex)) = 0;

end

