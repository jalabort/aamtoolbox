function [tex] = TransformWithoutSmoothing(obj,img)
  %TransformWithoutSmoothin Summary of this function goes here
  %   Detailed explanation goes here
  
  tex = zeros(obj.n_face_pixels1*obj.n_ch,1);
    
  for i = 1:obj.n_ch_img
    tex(1+obj.n_face_features1*(i-1):obj.n_face_features1*i) = ... 
          obj.TransformCh(img(:,:,i));
  end
  
end
