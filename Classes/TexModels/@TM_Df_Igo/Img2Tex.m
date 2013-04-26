function [tex] = Img2Tex(obj,img)
  %IMG2TEX Summary of this function goes here
  %   Detailed explanation goes here

  tex = zeros(obj.n_bin*obj.n_face_pixels,1);
  
  for i = 1:obj.n_bin
    aux = img(:,:,i);
    tex(1+obj.n_face_pixels*(i-1):obj.n_face_pixels*i) = aux(obj.mask);
  end

end

