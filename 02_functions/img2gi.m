function [gi_img] = img2gi(img)
  %img2gi Summary of this function goes here
  %   Detailed explanation goes here

  gi_img = zeros([size(img,1),size(img,2),2]);
  
  [gx,gy] = gradient(img);
  aux = gx + 1i*gy;
  gmag = abs(aux);
  n = gmag(obj.mask1) + median(gmag);
  norm_factor = repmat(n,[2,1]);
  gi_img(:,:,1) = gx ./ norm_factor;
  gi_img(:,:,2) = gy ./ norm_factor;
  
end

