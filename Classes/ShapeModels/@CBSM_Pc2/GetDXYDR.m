function [dxy_dr] = GetDXYDR(obj)
  %GETDXYDR Summary of this function goes here
  %   Detailed explanation goes here

  n_r_total = sum(obj.n_r);
  dxy_dr = zeros(2*obj.n_vert,n_r_total);
  s = 1;
  for i = 1:obj.n_comp
    e = s + obj.n_r(i) - 1;
    [dxy_dr(obj.i_comp_shape{i},s:e)] = obj.comp_pc{i}(:,1:obj.n_r(i));
    s = e + 1;
  end
  
end

