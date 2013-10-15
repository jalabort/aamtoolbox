function [delta,c] = Optimize(obj,i,~,tex,c,p)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(tex);
  
%   dWdp = obj.sm{i}.Compute_dWdp_p(obj.dWduvi{i},p);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  J2 = obj.tm{i}.Compute_DtS(J) + obj.tm{i}.Compute_DwS(J); 
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2));
  
  H = J2' * J;
  
  error = obj.t{i} - tex;
  error = obj.tm{i}.Compute_DtS(error) + obj.tm{i}.Compute_DwS(error);
  error = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(error));
  J_x_error = J' * error;
  delta = H \ J_x_error;
  
  %-----
  if obj.shape_reg ~= 0
    obj.sm{i}.sigma_inv_p = obj.tm{i}.variance^2 * inv(H);
  end
  %-----

end

