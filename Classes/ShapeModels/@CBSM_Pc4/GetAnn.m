function [qpr_ann,q,p,r] = GetAnn(obj,qpr)
  %GETANN Summary of this function goes here
  %   Detailed explanation goes here

  q = qpr(1:obj.n_q);
  p = qpr(obj.n_q+1:obj.n_q+obj.n_p);
  
  s = obj.n_q+obj.n_p+1;
  r = cell(obj.n_comp,1);
  for i = 1:obj.n_comp
    e = s + obj.n_r(i) - 1;
    r{i} = qpr(s:e);
    s = e + 1;
  end

  r_shape = obj.R2Shape(r);
  
  p_shape = obj.P2Shape(p);
  pr_shape = obj.ApplyP(r_shape,p_shape);
  
  [A,t] = obj.Q2MatForm(q);
  pr_ann = obj.Shape2Ann(pr_shape);
  qpr_ann = obj.ApplyQ(pr_ann,A,t);
  
end



