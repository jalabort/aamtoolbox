function [delta,c] = Optimize(obj,i,~,tex,c,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  [dtexdx,dtexdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  J = obj.tm{i}.Compute_dtdp(dtexdx,dtexdy,obj.dWdp{i});
  J2 = obj.tm{i}.ProjectOut(J);
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2));
  
  H = J2' * J;

  error = obj.t{i} - tex;
  error = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(error));
  J_x_error = J2' * error;
  delta = H \ J_x_error;
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.sigma_inv_p = obj.tm{i}.variance^2 * inv(H);
  end
  %-----

end

