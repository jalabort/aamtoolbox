function [digo_img] = img2igodouble(img)
  %img2igodouble Summary of this function goes here
  %   Detailed explanation goes here
  
  digo_img = zeros([size(img,1),size(img,2),4]);

  [gx,gy] = gradient(img);
  gdir = angle(gx + 1j*gy);
  gdir2 = 2 * gdir;
  ngx = cos(gdir);
  ngy = sin(gdir);
  ngx2 = cos(gdir2);
  ngy2 = sin(gdir2);
  digo_img(:,:,1) = ngx;
  digo_img(:,:,2) = ngy;
  digo_img(:,:,3) = ngx2;
  digo_img(:,:,4) = ngy2;
  
  
end

