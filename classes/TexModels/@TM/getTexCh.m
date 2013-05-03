function [tex_ch] = getTexCh(obj,tex,i)
  %GETTEXCH Summary of this function goes here
  %   Detailed explanation goes here

  tex_ch = tex(1+obj.n_face_pixels*(i-1):obj.n_face_pixels*i,:);

end

