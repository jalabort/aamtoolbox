function [igo_img] = img2igo(img)
  %img2igo Summary of this function goes here
  %   Detailed explanation goes here

  igo_img = zeros([size(img,1),size(img,2),2]);
  
  [gx,gy] = gradient(img);
  gdir = angle(gx + 1j*gy);
  ngx = cos(gdir);
  ngy = sin(gdir);
  norm_factor = sqrt(numel(img));
  igo_img(:,:,1) = ngx / norm_factor;
  igo_img(:,:,2) = ngy / norm_factor;
  
end

