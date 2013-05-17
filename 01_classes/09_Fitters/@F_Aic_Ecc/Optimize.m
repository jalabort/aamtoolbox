function [delta,c] = Optimize(obj,i,tex,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes her
  
  c = obj.tm{i}.Tex2C(tex);
  [t,tt] = obj.tm{i}.C2Tex(c);

  [dt_dx,dt_dy] = obj.tm{i}.ComputeDTDXY(t);

  g = obj.tm{i}.ComputeDTDQPR(obj.sm{i}.n_qpr,dt_dx,dt_dy,obj.dw_dp{i},t,tt);
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
  delta = inv_q * sd_delta;

end

