function igo_tex = TransformAll(obj,img,n_img,n_img_ch)
  %TRANSFORMALL Summary of this function goes here
  %   Detailed explanation goes here
  
  igo_tex = zeros(obj.n_ch*obj.n_face_pixels2,n_img);
  
  for i = 1:n_img
    igo_tex(:,i) = obj.Transform(img(:,:,:,i),n_img_ch);
  end
  
end
