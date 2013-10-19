function [dgi_img] = img2gidouble(img)
  %img2gidouble Summary of this function goes here
  %   Detailed explanation goes here
  
  dgi_img = zeros([size(img,1),size(img,2),4]);

  [gx,gy] = gradient(img);
  aux = gx + 1i*gy;
  gdir = angle(aux);
  gdir2 = 2 * gdir;
  gmag = abs(aux);
  ngx = cos(gdir);
  ngy = sin(gdir);
  ngx2 = cos(gdir2);
  ngy2 = sin(gdir2);
  n = gmag + median(gmag(:));
  norm_factor = gmag ./ n;
  dgi_img(:,:,1) = ngx .* norm_factor;
  dgi_img(:,:,2) = ngy .* norm_factor;
  dgi_img(:,:,3) = ngx2 .* norm_factor;
  dgi_img(:,:,4) = ngy2 .* norm_factor;

  
end

