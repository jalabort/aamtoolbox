function [m_shape] = Shape2MassShape(obj,shape)
  %SHAPE2MASSSHAPE Summary of this function goes here
  %   Detailed explanation goes here
  
  m_shape = zeros(2*obj.n_comp,1);
  for i = 1:obj.n_comp
    m_shape(i) = mean(shape(obj.i_comp_ann{i},:));
    m_shape(i+obj.n_comp) = mean(shape(obj.n_vert+obj.i_comp_ann{i},:));
  end

end

