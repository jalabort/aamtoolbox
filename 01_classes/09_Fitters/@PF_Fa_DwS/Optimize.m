function [delta,c] = Optimize(obj,i,tex,c,p)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here

  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  dWdp = obj.sm{i}.Compute_dWdp_p(obj.dWduvi{i},p);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,dWdp);
  J = obj.tm{i}.pc(:,1:obj.tm{i}.n_c) * ...
    diag(1./obj.tm{i}.ev(1:obj.tm{i}.n_c)) * ...
    (obj.tm{i}.pc(:,1:obj.tm{i}.n_c)' * J);
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  
  H = J' * J;
  
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));  

  error = obj.t{i} - tex;
  J_x_error = J' * error;
  delta = H \ J_x_error;

end

