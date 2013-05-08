function [cimg] = ColorTransform2(~,img)
  %COLORTRANSFORM Summary of this function goes here
  %   Detailed explanation goes here

  if size(img,3) == 1
    cimg = zeros([size(img,1),size(img,2),3]);
    cimg(:,:,1) = img;
    cimg(:,:,2) = img;
    cimg(:,:,3) = img;
  else
    cimg = img;
  end

end

