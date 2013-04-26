function [delta,c] = Optimize(obj,i,tex,c)
  %OPTIMIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  [dt_dx,dt_dy] = obj.tm{i}.ComputeDTDXY(tex);
  
  g = obj.tm{i}.ComputeDTDQPR(obj.sm{i}.n_qpr,dt_dx,dt_dy,obj.dw_dp{i},tex,[]);
  q = g' * obj.tm{i}.ProjectOut(g);

  tex_error = obj.tm{i}.ProjectOut(tex);
  sd_delta = g' * tex_error;
  delta = - q \ sd_delta;

end

