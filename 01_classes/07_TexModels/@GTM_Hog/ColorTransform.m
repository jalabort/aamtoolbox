function [img] = ColorTransform(img)
  %ColorTransform Summary of this function goes here
  %   Detailed explanation goes here

  if size(img,3) == 3
    img = rgb2gray(img);
  end
  
  if isinteger(img)
    img = double(img) / 255;
  end

end

