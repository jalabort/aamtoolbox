function [delta,c] = Optimize(obj,i,tex,~,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  c = obj.tm{i}.Tex2C(tex);
  t = obj.tm{i}.C2Tex(c);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  J = obj.tm{i}.ProjectOut(J);
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  
  H = J' * J;
  
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  error = t - tex;
  J_x_error = J' * error;
  delta = H \ J_x_error;
  
end

