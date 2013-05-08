function [shape] = R2Shape2(obj,r)
  %R2SHAPE2 Summary of this function goes here
  %   Detailed explanation goes here

  shape = zeros(2*obj.n_vert,1);
  for i = 1:obj.n_comp
    shape(obj.i_comp_shape{i}) = obj.pca.Coeff2Data(zeros(size(obj.comp_mu{i})),obj.comp_pc{i},r{i});
  end
  
end

