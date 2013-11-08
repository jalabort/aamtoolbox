function [delta,ck,H] = Optimize(obj,i,~,tex,c0,~)
  %Optimize Summary of this function goes here
  %   Detailed explanation goes here
  
  ck = obj.tm{i}.Tex2C(tex);
  %-----
  if obj.tex_reg == 1
    t2 = obj.tm{i}.C2Tex(ck);
    t2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t2));
    tex2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));
    error2 = t2 - tex2;
    var = (error2' * error2) / (obj.tm{i}.n_face_pixels2 - obj.tm{i}.n_c);
    sigma_aux =  var * (obj.tm{i}.pc(:,1:obj.tm{i}.n_c)' * obj.tm{i}.pc(:,1:obj.tm{i}.n_c));
    inv_sigma = inv(obj.tm{i}.sigma_c0) + inv(sigma_aux);
    ck = inv_sigma \ (sigma_aux \ ck + obj.tm{i}.sigma_c0 \ c0);
  elseif obj.tex_reg == 2
    t2 = obj.tm{i}.C2Tex(ck);
    t2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(t2));
    tex2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(tex));
    error2 = t2 - tex2;
    var = (error2' * error2) / (obj.tm{i}.n_face_pixels2 - obj.tm{i}.n_c);
    P = obj.tm{i}.sigma_c0 + obj.sigma_ck{i};
    K = P  / (P + var * (obj.tm{i}.pc(:,1:obj.tm{i}.n_c)' * obj.tm{i}.pc(:,1:obj.tm{i}.n_c)));
    ck = c0 + K * (ck - c0);
    obj.sigma_ck{i} = (eye(size(K)) - K) * P;
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
    var = (error' * error) / (obj.tm{i}.n_face_pixels2 - obj.sm{i}.n_p);
    obj.w{i}.sigma_inv_p = var * inv(H);
  end
  %-----
  
end
