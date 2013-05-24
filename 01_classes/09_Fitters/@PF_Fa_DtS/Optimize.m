function [delta,c] = Optimize(obj,i,tex,c)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  dWdp = obj.sm{i}.Compute_dWdp(obj.dWduvi{i});
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,dWdp);
  J = 1 / obj.tm{i}.variance * ...
    (J - ...
    obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c) * ...
    (obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c)' * J)); 
  
  H = J' * J;
  
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));  

  error = obj.t{i} - tex;
  J_x_error = J' * error;
  delta = H \ J_x_error;

end

