function [qp_ann] = PrepareComposition(obj,delta)
  %PREPARECOMPOSITION Summary of this function goes here
  %   Detailed explanation goes here

  delta_q = delta(1:obj.n_q);
  delta_p = delta(obj.n_q+1:end);
  
  [A,t] = obj.Q2MatForm(delta_q);
  
  p_shape = obj.P2Shape(delta_p);
  p_ann = obj.Shape2Ann(p_shape);
  
  qp_ann = obj.ApplyQ(p_ann,A,t);
  
end

