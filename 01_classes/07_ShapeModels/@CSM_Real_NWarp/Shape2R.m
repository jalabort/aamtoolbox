function [r] = Shape2R(obj,shape)
  %Shape2R Summary of this function goes here
  %   Detailed explanation goes here

  r = zeros(sum(obj.n_r),1);
  s = 1;
  for i = 1:obj.n_part
    e = s + obj.n_r(i) - 1;
    r(s:e) = obj.pca.Data2Coeff(obj.part_mu{i},obj.part_pc{i},shape(obj.i_part_shape{i}));
    s = e + 1;
  end
  
end

