function [delta_p,ck] = Optimize(obj,i,j,tex,c0,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  if j == 1
    c0 = obj.tm{i}.Tex2C(tex);
  end
  
  t = obj.tm{i}.C2Tex(c0);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  J2 = obj.tm{i}.ProjectOut(J);
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2));
  
  H = J2' * J2;

  err = t - tex;
  err2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(err));
  
  J_x_error = J2' * err2;
  delta_p = H \ J_x_error;
  
  ck = c0 - obj.tm{i}.Tex2C(err + J * delta_p);
  %-----
  if obj.tex_reg ~= 0
    inv_sigma = obj.tm{i}.inv_sigma_c0 + obj.tm{i}.inv_sigma_ck;
    ck = inv_sigma \ (obj.tm{i}.inv_sigma_ck * ck + obj.tm{i}.inv_sigma_c0 * c0);
    obj.tm{i}.inv_sigma_c0 = inv_sigma;
  end
  if obj.shape_reg ~= 0
    obj.sm{i}.sigma_inv_p = obj.tm{i}.variance^2 * inv(H);
  end
  %-----
  
end

