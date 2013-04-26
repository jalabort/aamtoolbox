function [qp_ann,q,p,r] = QPR2Ann(obj,qpr)
  %QPR2ANN Summary of this function goes here
  %   Detailed explanation goes here

  q = qpr(1:obj.n_q);
  p = qpr(obj.n_q+1:obj.n_q+obj.n_p);
  r = [];
  
  p_shape = obj.P2Shape(p);
  p_ann = obj.Shape2Ann(p_shape);
  
  [A,t] = obj.Q2MatForm(q);
  qp_ann = obj.ApplyQ(p_ann,A,t);
  
end



