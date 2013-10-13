function [delta,c] = Optimize(obj,i,~,tex,~,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  c = obj.tm{i}.Tex2C(tex);
  t = obj.tm{i}.C2Tex(c);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  [dtexdx,dtexdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  Jt = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  Jt = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(Jt));
  
  Jtex = obj.tm{i}.Compute_dtdp(dtexdx,dtexdy,obj.dWdp{i});
  Jtex= obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(Jtex));
  
  J = 0.5 * (Jtex + Jt);
  H = J' * J;
  
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  error = t - tex;
  J_x_error = J' * error;
  delta = 0.5 * H \ J_x_error;
  delta = [delta; delta];
  
end
