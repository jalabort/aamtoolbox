function [delta,c] = Optimize(obj,i,j,tex,c,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here

  if j == 1
    c = obj.tm{i}.Tex2C(tex);
  end
        
  t = obj.tm{i}.C2Tex(c);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  
  dAdp = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  dAdp = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dAdp));

  dAdc = obj.tm{i}.Compute_dAdc();
  dAdc = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(dAdc));

  J = [dAdp,dAdc];
  H = J' * J;
  
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  error = t - tex;
  J_x_error = J' * error;
  delta = H \ J_x_error;
  
  c = c + delta(obj.sm{i}.n_p+1:end);
  delta = delta(1:obj.sm{i}.n_p);
    
end

