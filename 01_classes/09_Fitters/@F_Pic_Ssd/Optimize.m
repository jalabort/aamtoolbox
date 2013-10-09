function [delta,c] = Optimize(obj,i,~,tex,c,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  error = obj.t{i} - tex;
  error = obj.tm{i}.ProjectOut(error);
  error = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(error));
  J_x_error = obj.J{i}' * error;
  delta = obj.invH{i} * J_x_error;

end

