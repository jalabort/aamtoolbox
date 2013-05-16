function [cimg,n_img_ch] = ColorTransformAll(img)
  %ColorTransformAll Summary of this function goes here
  %   Detailed explanation goes here

  n_img_ch = 1;
  n_img = size(img,4);
  cimg = zeros(size(img,1),size(img,2),n_img_ch,n_img);
  
  for i = 1:n_img
    cimg(:,:,:,i) = TM.ColorTransform(img(:,:,:,i));
  end

end

