function [deuler_img] = img2eulerdouble(img)
  %img2eulerdouble Summary of this function goes here
  %   Detailed explanation goes here

  dir = img * alpha * pi;
  dir2 = 2 * dir;
  nx = cos(dir);
  ny = sin(dir);
  nx2 = cos(dir2);
  ny2 = sin(dir2);
  deuler_img = [nx;ny;nx2;ny2];
  
end

