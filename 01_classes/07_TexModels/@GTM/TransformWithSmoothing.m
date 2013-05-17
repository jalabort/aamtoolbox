function [stex] = TransformWithSmoothing(obj,img)
  %TransformWithSmoothin Summary of this function goes here
  %   Detailed explanation goes here
  
  stex = zeros(obj.n_face_pixels1*obj.n_ch,1);
    
  for i = 1:obj.n_ch_img
    simg_ch = obj.smoother.Run(img(:,:,i));
    stex(1+obj.n_face_features*(i-1):obj.n_face_features*i) = ... 
          obj.TransformCh(simg_ch(:,:,i));
  end
  
end
