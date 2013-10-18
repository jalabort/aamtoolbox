function [delta,ck] = Optimize(obj,i,~,tex,c0,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  %-----
  if obj.tex_reg == 2
    P = obj.tm{i}.sigma_ck;
    C = obj.tm{i}.pc(:,1:obj.tm{i}.n_c);
    %inv_var = diag(ones(size(tex)) ./ obj.tm{i}.variance);
    %Cs = (1 / obj.tm{i}.variance) * C;
    %K = P  * C' * ...
    %  (inv_var - (Cs / (inv(P) + C' * Cs)) * Cs');
    %PC = P  * C' * ...
    %  (inv_var - (Cs / (inv(P) + C' * Cs)) * Cs');
    PC = P  * C';
    aux = tex - obj.tm{i}.C2Tex(c0);
    ck = c0 + PC *(obj.tm{i}.Compute_DtS(aux) + obj.tm{i}.Compute_DwS(aux));
    CP = C * P;
    obj.tm{i}.sigma_ckk = P - PC *(obj.tm{i}.Compute_DtS(CP) + obj.tm{i}.Compute_DwS(CP));
    obj.tm{i}.sigma_ck = obj.tm{i}.sigma_ckk + P;
    obj.tm{i}.mu = obj.tm{i}.C2Tex(ck);
  else
    ck = c0;
  end
  %-----

  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(tex);
  
  J = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  J2 = obj.tm{i}.Compute_DtS(J) + obj.tm{i}.Compute_DwS(J); 
  J = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J));
  J2 = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(J2));
  
  H = J2' * J;
  
  error = obj.tm{i}.mu - tex;
  error = obj.tm{i}.Compute_DtS(error) + obj.tm{i}.Compute_DwS(error);
  error = obj.tm{i}.Img2CroppedTex(obj.tm{i}.Tex2Img(error));
  J_x_error = J' * error;
  delta = H \ J_x_error;
  
  %-----
  if obj.shape_reg ~= 0
    obj.w{i}.sigma_inv_p = obj.tm{i}.variance^2 * inv(H);
  end
  %-----

end

