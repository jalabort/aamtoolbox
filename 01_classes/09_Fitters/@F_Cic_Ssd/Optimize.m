function [delta_p,c] = Optimize(obj,i,tex,c,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  if j == 1
    c = obj.tm{i}.Tex2C(tex);
  end
  
  t = obj.tm{i}.C2Tex(c);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  J = obj.tm{i}.ProjectOut(J);
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  
  H = J2' * J2;

  err = t - tex;
  err2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(err));
  
  J_x_error = J2' * err2;
  delta_p = H \ J_x_error;
  
  delta_c = obj.tm{i}.Tex2C(err + J * delta_p);
  c = c - delta_c;
  
end

