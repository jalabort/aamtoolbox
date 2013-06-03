function [ctex_ch] = GetCroppedTexCh(obj,ctex,i)
  %GetCroppedTexCh Summary of this function goes here
  %   Detailed explanation goes here

  ctex_ch = ctex(1+obj.n_face_pixels2*(i-1):obj.n_face_pixels2*i,:);

end

