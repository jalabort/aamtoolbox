function [ctex] = Img2CroppedTex(obj,img)
  %Img2CroppedTex Summary of this function goes here
  %   Detailed explanation goes here

  n_img = size(img,4);
  ctex = zeros(obj.n_ch*obj.n_face_pixels2,n_img);
  
  for i = 1:n_img
    for j = 1:obj.n_ch
      aux = img(:,:,j,i);
      ctex(1+obj.n_face_pixels2*(j-1):obj.n_face_pixels2*j,i) = ...
        aux(obj.mask2);
    end
  end

end

