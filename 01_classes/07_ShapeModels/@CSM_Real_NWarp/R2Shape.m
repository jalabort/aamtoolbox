function [shape] = R2Shape(obj,r)
  %R2Shape Summary of this function goes here
  %   Detailed explanation goes here

  shape = zeros(2*obj.n_vert,1);
  s = 1;
  for i = 1:obj.n_part
    e = s + obj.n_r(i) - 1;
    shape(obj.i_part_shape{i}) = obj.pca.Coeff2Data(obj.part_mu{i},obj.part_pc{i},r(s:e));
    s = e + 1;
  end
  
end

