function [delta_p,c] = Optimize(obj,i,j,tex,c,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  if j == 1
    c = obj.tm{i}.Tex2C(tex);
  end
  
  t = obj.tm{i}.C2Tex(c);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  [dtexdx,dtexdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  Jt = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  Jtex = obj.tm{i}.Compute_dtdp(dtexdx,dtexdy,obj.dWdp{i});
  
  J = 0.5 * (Jtex + Jt);
  J2 = obj.tm{i}.ProjectOut(J);
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2));
  
  H = J2' * J2;

  err = t - tex;
  err2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(err));
  
  J_x_error = J2' * err2;
  delta_p = 0.5 * H \ J_x_error;
  
  delta_c = obj.tm{i}.Tex2C(err + J * delta_p);
  c = c - delta_c;
  
  delta_p = [delta_p; delta_p];
  
end

