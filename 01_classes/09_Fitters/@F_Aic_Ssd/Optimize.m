function [delta,ck] = Optimize(obj,i,~,tex,c0,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  ck = obj.tm{i}.Tex2C(tex);
  %-----
  if obj.tex_reg == 1
    inv_sigma = (inv(obj.tm{i}.sigma_c0) + inv(obj.tm{i}.sigma_ck{i}));
    ck = inv_sigma \ (obj.sigma_ck{i} \ ck + obj.tm{i}.sigma_c0 \ c0);
  elseif obj.tex_reg == 2
    P = obj.tm{i}.sigma_c0 + obj.sigma_ck{i};
    K = P  / (P + inv(obj.tm{i}.sigma_ck));
    ck = c0 + K * (ck - c0);
    obj.sigma_ck{i} = (eye(size(K)) - K) * P;
  end
  %-----
  t = obj.tm{i}.C2Tex(ck);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  
  H = J' * J;
  
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  error = t - tex;
  J_x_error = J' * error;
  delta = H \ J_x_error;
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.sigma_inv_p = obj.tm{i}.variance * inv(H);
  end
  %-----
  
end

