function [cimg] = ColorTransform(~,img)
  %COLORTRANSFORM Summary of this function goes here
  %   Detailed explanation goes here

  if size(img,3) == 3
    cimg = rgb2gray(img);
  else
    cimg = img;
  end

end

