function [qp_ann,q,p,r] = GetAnn(obj,qp)
  %GETANN Summary of this function goes here
  %   Detailed explanation goes here

  q = qp(1:obj.n_q);
  p = qp(obj.n_q+1:end);
  r = [];
  
  q_shape = obj.Q2Shape(q);
  p_shape = obj.P2Shape(p);
  
%   qp_shape = q_shape + p_shape - obj.sim_mu;
%   qp_ann = obj.Shape2Ann(qp_shape);

  [A,t] = obj.Q2MatForm(q);
  p_ann = obj.Shape2Ann(p_shape);
  qp_ann = obj.ApplyQ(p_ann,A,t);
  
end



