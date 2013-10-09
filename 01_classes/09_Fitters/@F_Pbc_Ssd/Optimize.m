function [delta,c] = Optimize(obj,i,~,tex,c,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  [dtexdx,dtexdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  Jtex = obj.tm{i}.Compute_dtdp(dtexdx,dtexdy,obj.dWdp{i});
  Jtex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(Jtex));
  
  J = [obj.Jt{i}, Jtex];
  
  H = J' * J;

  error = obj.t{i} - tex;
  error = obj.tm{i}.ProjectOut(error);
  error = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(error));
  J_x_error = J' * error;
  delta = H \ J_x_error;

end
