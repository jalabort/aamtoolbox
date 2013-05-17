function [delta,c] = Optimize(obj,i,tex,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  c = obj.tm{i}.Tex2C(tex);
  t = obj.tm{i}.C2Tex(c);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  
  J = obj.tm{i}.Compute_dtdp(obj.sm{i}.n_p,dtdx,dtdy,obj.dWdp{i});
  J = obj.tm{i}.ProjectOut(J);
  
  H = J' * J;
  
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img2(tex));

  error = t - tex;
  J_x_error = J' * error;
  delta = - H \ J_x_error;
  
end

