function [delta,ck,H] = Optimize(obj,i,~,tex,c0,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  ck = obj.tm{i}.Tex2C(tex);
  %-----
  if obj.tex_reg == 1
    inv_sigma_c0 = inv(obj.tm{i}.sigma_c0); 
    inv_sigma_ck = inv(obj.tm{i}.sigma_ck);
    sigma = inv(inv_sigma_c0 + inv_sigma_ck);
    ck = sigma * (inv_sigma_ck * ck + inv_sigma_c0 * c0);
    %obj.tm{i}.sigma_c0 = sigma;
  elseif obj.tex_reg == 2
    P = obj.tm{i}.sigma_c0 + obj.tm{i}.sigma_ck;
    K = P  / (P + inv(obj.tm{i}.sigma_ck));
    ck = c0 + K * (ck - c0);
    obj.tm{i}.sigma_ck = (eye(size(K)) - K) * P;
  end
  %-----
  t = obj.tm{i}.C2Tex(ck);
  
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(t);
  [dtexdx,dtexdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  Jt = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  Jt = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(Jt));
  
  Jtex = obj.tm{i}.Compute_dtdp(dtexdx,dtexdy,obj.dWdp{i});
  Jtex= obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(Jtex));
  
  J = 0.5 * (Jtex + Jt);
  H = J' * J;
  
  t = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t));
  tex = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));

  error = t - tex;
  J_x_error = J' * error;
  delta = 0.5 * H \ J_x_error;
  delta = [delta; delta];
  
   %-----
  if obj.shape_reg ~= 0
    obj.w{i}.sigma_inv_p = obj.tm{i}.variance^2 * inv(H);
  end
  %-----
  
end
