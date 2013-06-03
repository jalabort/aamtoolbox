function [tex] = TransformAll(obj,img)
  %TRANSFORMALL Summary of this function goes here
  %   Detailed explanation goes here
  
  n_img = size(img,4);
  tex = zeros(obj.n_ch*obj.n_face_pixels1,n_img);
  
  for i = 1:n_img
    tex(:,i) = obj.Transform(img(:,:,:,i));
  end
  
end
