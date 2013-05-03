function [delta,c,H,ecc] = Optimize(obj,i,tex,~)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  c = obj.tm{i}.Tex2C(tex);
  [t,tt] = obj.tm{i}.C2Tex(c);
  
  [dt_dx,dt_dy] = obj.tm{i}.ComputeDTDXY(t);
  
  J = obj.tm{i}.ComputeDTDQPR(obj.sm{i}.n_qpr,dt_dx,dt_dy,obj.dw_dp{i},t,tt);
  J = obj.tm{i}.ProjectOut(J);
  
  H = J' * J;
  
  t = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(t));
  tex = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(tex));

  tex_error = t - tex;
  sd_delta = J' * tex_error;
  delta = - H \ sd_delta;

  ecc = t'*tex;
  
end

