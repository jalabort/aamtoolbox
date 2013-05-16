function [tex] = TransformCh(obj,img)
  %TrandformCh Summary of this function goes here
  %   Detailed explanation goes here
  
  [gx,gy] = gradient(img);
  aux = gx + 1i*gy;
  gdir = angle(aux);
  gmag = abs(aux);
  ngx = cos(gdir);
  ngy = sin(gdir);
  n = gmag(obj.mask1) + median(gmag(obj.mask1));
  tex = [ngx(obj.mask1);ngy(obj.mask1)] ./ repmat(n,[2,1]);
  
  tex(isnan(tex)) = 0;
  tex(isinf(tex)) = 0;
  
end

