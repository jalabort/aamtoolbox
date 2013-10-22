function [igo_img] = img2igo(img)
  %img2igo Summary of this function goes here
  %   Detailed explanation goes here

  igo_img = zeros([size(img,1),size(img,2),2]);
  
  [gx,gy] = gradient(img);
  gdir = angle(gx + 1j*gy);
  ngx = cos(gdir);
  ngy = sin(gdir);
  igo_img(:,:,1) = ngx;
  igo_img(:,:,2) = ngy;
  
end

