function [euler_img] = img2euler(img,alpha)
  %img2euler Summary of this function goes here
  %   Detailed explanation goes here
  
  euler_img = zeros([size(img,1),size(img,2),2]);

  dir = img * alpha * pi;
  nx = cos(dir);
  ny = sin(dir);
  euler_img(:,:,1) = nx;
  euler_img(:,:,2) = ny;
  
end

