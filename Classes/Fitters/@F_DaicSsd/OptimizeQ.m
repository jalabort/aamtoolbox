function [delta,c] = OptimizeQ(obj,i,tex,~)
  %OPTIMIZEQ Summary of this function goes here
  %   Detailed explanation goes her
  
  c = obj.tm{i}.Tex2C(tex);
  [t,tt] = obj.tm{i}.C2Tex(c);
  
  [dt_dx,dt_dy] = obj.tm{i}.ComputeDTDXY(t);
  
  g = obj.tm{i}.ComputeDTDQPR(obj.sm{i}.n_q,dt_dx,dt_dy,obj.dw_dq{i},t,tt);
  
  q = g' * g;
  
  t = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(t));
  tex = obj.tm{i}.Img2Tex(obj.tm{i}.Tex2Img2(tex));

  tex_error = t - tex;
  sd_delta = g' * tex_error;
  delta_qp = - q \ sd_delta;
  
  delta_pr = zeros(obj.sm{i}.n_p+sum(obj.sm{i}.n_r),1);
  
  delta = [delta_qp;delta_pr];

end

