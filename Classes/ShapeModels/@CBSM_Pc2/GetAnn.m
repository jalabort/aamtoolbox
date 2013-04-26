function [qpr_ann,q,p,r] = GetAnn(obj,qpr)
  %GETANN Summary of this function goes here
  %   Detailed explanation goes here

  q = qpr(1:obj.n_q);
  s = obj.n_q + obj.n_p;
  p = qpr(obj.n_q+1:s);

  s = obj.n_q+obj.n_p+1;
  r = cell(obj.n_comp,1);
  for i = 1:obj.n_comp
    e = s + obj.n_r(i) - 1;
    r{i} = qpr(s:e);
    s = e + 1;
  end
  
  q_shape = obj.Q2Shape2(q); 
  p_shape = obj.P2Shape2(p);
  r_shape = obj.R2Shape2(r);
  
  qpr_shape = q_shape + p_shape + r_shape;
  
  qpr_ann = obj.Shape2Ann(qpr_shape);
  
end

