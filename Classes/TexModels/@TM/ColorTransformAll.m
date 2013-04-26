function [cimg,n_img_ch] = ColorTransformAll(obj,img,n_img)
  %COLORTRANSFORMALL Summary of this function goes here
  %   Detailed explanation goes here

  n_img_ch = 1;
  cimg = zeros(size(img,1),size(img,2),n_img_ch,n_img);
  
  for i = 1:n_img
    cimg(:,:,:,i) = obj.ColorTransform(img(:,:,:,i));
  end

end

