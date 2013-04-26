function [tex] = Img2Tex2(obj,img)
  %IMG2TEX2 Summary of this function goes here
  %   Detailed explanation goes here

  n_img = size(img,4);
  tex = zeros(obj.n_ch*obj.n_face_pixels2,n_img);
  
  for i = 1:n_img
    for j = 1:obj.n_ch
      aux = img(:,:,j,i);
      tex(1+obj.n_face_pixels2*(j-1):obj.n_face_pixels2*j,i) = aux(obj.mask2);
    end
  end

end

