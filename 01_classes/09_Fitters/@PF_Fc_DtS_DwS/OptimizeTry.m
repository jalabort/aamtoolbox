function [delta,c] = Optimize(obj,i,~,tex,c,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  
  c_J = obj.tm{i}.Tex2C(J);
  A =  ((1/obj.tm{i}.variance) * ...
    eye(obj.tm{i}.n_c) - ...
    diag(1./obj.tm{i}.ev(1:obj.tm{i}.n_c)));
  
  H = (1/obj.tm{i}.variance) * (J' * J) - ...
    c_J' * (A * c_J);
   
  err = obj.t{i} - tex;
  
  c_err =  obj.tm{i}.Tex2C(err);
  
  err = (1/obj.tm{i}.variance) * err - ...
    c_err' * (A * c_err);
  
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  err = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(err));
  
  J_x_err = J' * err;
  delta = H \ J_x_err;

end

