function [r] = Shape2R(obj,shape)
  %SHAPE2R Summary of this function goes here
  %   Detailed explanation goes here

  r = cell(1,obj.n_comp);
  for i = 1:obj.n_comp
    r{i} = obj.pca.Data2Coeff(obj.comp_mu{i},obj.comp_pc{i}(:,1:obj.n_r(i)),shape(obj.i_comp_shape{i}));
  end

end

