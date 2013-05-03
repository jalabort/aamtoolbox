function [igo_tex,n_img_ch] = TrainTransformAll(obj,img,n_img,n_img_ch)
  %TRAINTRANSFORMALL Summary of this function goes here
  %   Detailed explanation goes here
  
  igo_tex = zeros(2*obj.n_face_pixels*n_img_ch,n_img);
  
  for i = 1:n_img
    igo_tex(:,i) = obj.TrainTransform(img(:,:,:,i),n_img_ch);
  end
  
  n_img_ch = 2 * n_img_ch;

end
