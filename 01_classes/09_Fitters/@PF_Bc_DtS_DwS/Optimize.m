function [delta,c] = Optimize(obj,i,~,tex,c,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  [dtexdx,dtexdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  Jtex = obj.tm{i}.Compute_dtdp(dtexdx,dtexdy,obj.dWdp{i});
  
  J = [Jtex, obj.Jt{i}];
  J2 = obj.tm{i}.Compute_DtS(J) + obj.tm{i}.Compute_DwS(J); 
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2));
  
  H = J2' * J;
  
  error = obj.tm{i}.mu - tex;
  error = obj.tm{i}.Compute_DtS(error) + obj.tm{i}.Compute_DwS(error);
  error = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(error));
  J_x_error = J' * error;
  delta = 0.5 * H \ J_x_error;
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.sigma_inv_p = obj.tm{i}.variance^2 * inv(H);
  end
  %-----

end

