function [dx_dr,dy_dr] = ComputeDXYDR(obj)
  %COMPUTEDXYDR Summary of this function goes here
  %   Detailed explanation goes here

  n_r_total = sum(obj.n_r);
  dx_dr = zeros(obj.n_vert,n_r_total);
  dy_dr = zeros(obj.n_vert,n_r_total);
  s = 1;
  for i = 1:obj.n_comp
    e = s + obj.n_r(i) - 1;
    [dx_dr(obj.i_comp_ann{i},s:e),dy_dr(obj.i_comp_ann{i},s:e)] = obj.Shape2XY(obj.comp_pc{i}(:,1:obj.n_r(i)));
    s = e + 1;
  end
end

