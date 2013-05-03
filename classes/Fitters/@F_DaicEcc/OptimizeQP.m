function [delta,c] = OptimizeQP(obj,i,tex,~)
  %OPTIMIZEQP Summary of this function goes here
  %   Detailed explanation goes her
  
  c = obj.tm{i}.Tex2C(tex);
  [t,tt] = obj.tm{i}.C2Tex(c);

  [dt_dx,dt_dy] = obj.tm{i}.ComputeDTDXY(t);
  
%   sigma = 1;
%   siz = 2*sigma+1;
%   H = fspecial('gaussian',[siz siz],sigma);
%   dt_dx = imfilter(dt_dx,H,'replicate');
%   dt_dy = imfilter(dt_dy,H,'replicate');
  
  g = obj.tm{i}.ComputeDTDQPR(obj.sm{i}.n_q+obj.sm{i}.n_p,dt_dx,dt_dy,obj.dw_dqp{i},t,tt);
  q = g' * g;
  inv_q = inv(q);
  
  t = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(t));
  tex = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(tex));

  v = t' * t;
  v_bold = g' * t;
  num = v - v_bold' * inv_q * v_bold;

  u = t' * tex;
  u_bold = g' * tex;
  aux = u_bold' * inv_q * v_bold;
  den = u - aux;

  if u >  aux
    lambda = num / den;
  else
    if u <=  aux
      lambda1 = sqrt((v_bold' / q * v_bold) / (u_bold' / q * u_bold));
      lambda2 = (u_bold' / q * v_bold - u) / (u_bold' / q * u_bold);
      lambda = max(lambda1,lambda2);
    else
      disp('Error in computation of lambda');
    end
  end

  sd_delta = lambda * u_bold - v_bold;
  delta_qp = inv_q * sd_delta;
  
  delta_r = zeros(sum(obj.sm{i}.n_r),1);
  
  delta = [delta_qp;delta_r];

end

