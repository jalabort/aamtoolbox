function [rshape] = ApplyR(obj,r,shape)
  %ApplyR Summary of this function goes here
  %   Detailed explanation goes here

  rshape = zeros(2*obj.n_vert,1);
  s = 1;
  for i = 1:obj.n_part
    e = s + obj.n_r(i) - 1;
    rshape(obj.i_part_shape{i}) = ...
      obj.pca.Coeff2Data(shape(obj.i_part_shape{i}), ...
                         obj.part_pc{i}(:,1:obj.n_r(i)), ...
                         r(s:e));
    s = e + 1;
  end
  
end

