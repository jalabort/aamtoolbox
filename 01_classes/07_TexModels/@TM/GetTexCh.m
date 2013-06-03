function [tex_ch] = GetTexCh(obj,tex,i)
  %GetTexCh Summary of this function goes here
  %   Detailed explanation goes here

  tex_ch = tex(1+obj.n_face_pixels1*(i-1):obj.n_face_pixels1*i,:);

end

