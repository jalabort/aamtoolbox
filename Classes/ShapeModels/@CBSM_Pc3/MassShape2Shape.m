function [shape] = MassShape2Shape(obj,m_shape)
  %MASSSHAPE2SHAPE Summary of this function goes here
  %   Detailed explanation goes here
  
  shape = zeros(obj.n_vert,size(m_shape,2));
  for i = 1:obj.n_comp
    shape(obj.i_comp_shape{i},:) = [repmat(m_shape(i,:),[length(obj.i_comp_ann{i}) 1]);repmat(m_shape(i+obj.n_comp,:),[length(obj.i_comp_ann{i}) 1])];
  end

end

