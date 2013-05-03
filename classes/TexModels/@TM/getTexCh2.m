function [tex_ch] = getTexCh2(obj,tex,i)
  %GETTEXCH2 Summary of this function goes here
  %   Detailed explanation goes here

  tex_ch = tex(1+obj.n_face_pixels2*(i-1):obj.n_face_pixels2*i,:);

end

