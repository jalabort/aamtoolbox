function [delta,c,H] = Optimize(obj,i,~,tex,c0,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  c = obj.tm{i}.Tex2C(tex);
  %-----
  if obj.tex_reg ~= 0
    inv_sigma = obj.tm{i}.inv_sigma_c0 + obj.tm{i}.inv_sigma_ck;
    c = inv_sigma \ (obj.tm{i}.inv_sigma_ck * c + obj.tm{i}.inv_sigma_c0 * c0);
    %obj.tm{i}.sigma_c0 = sigma;
  end
  %-----
  t = obj.tm{i}.C2Tex(c);
  
  [dtexdx,dtexdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  J = obj.tm{i}.Compute_dtdp(dtexdx,dtexdy,obj.dWdp{i});
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  
  H = J' * J;
  
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  error = t - tex;
  J_x_error = J' * error;
  delta = H \ J_x_error;
  
  %-----
  if obj.shape_reg ~= 0
    obj.sm{i}.sigma_inv_p = obj.tm{i}.variance^2 * inv(H);
  end
  %-----
  
end
