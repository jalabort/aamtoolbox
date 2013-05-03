function [delta,c] = Optimize(obj,i,tex,c)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  tex = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(tex));
  
  tex_error = obj.t{i} - tex;
  sd_delta = obj.g{i}' * tex_error;
  delta = - 0.2 * obj.inv_q{i} * sd_delta;

end

