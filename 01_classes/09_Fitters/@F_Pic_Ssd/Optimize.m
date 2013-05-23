function [delta,c] = Optimize(obj,i,tex,c)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  error = obj.t{i} - tex;
  J_x_error = obj.J{i}' * error;
  delta = obj.invH{i} * J_x_error;
  delta = 0.1 * delta;

end

