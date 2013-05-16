function [tex] = Img2Tex(obj,img)
  %Img2Tex Summary of this function goes here
  %   Detailed explanation goes here

  n_img = size(img,4);
  tex = zeros(obj.n_ch*obj.n_face_pixels1,n_img);
  
  for i = 1:n_img
    for j = 1:obj.n_ch
      aux = img(:,:,j,i);
      tex(1+obj.n_face_pixels1*(j-1):obj.n_face_pixels1*j,i) = ...
        aux(obj.mask1);
    end
  end

end

