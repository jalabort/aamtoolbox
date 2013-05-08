function [qpr_ann] = PrepareComposition(obj,delta)
  %PREPARECOMPOSITION Summary of this function goes here
  %   Detailed explanation goes here

  delta_q = delta(1:obj.n_q);
  s = obj.n_q + obj.n_p;
  delta_p = delta(obj.n_q+1:s);

  delta_r = cell(obj.n_comp,1);
  for i = 1:obj.n_comp
    if obj.n_r(i) > 0
      delta_r{i} = delta(s+1:s+obj.n_r(i));
      s = s + obj.n_r(i);
    else
      delta_r{i} = 0;
    end
  end
  
  [A,t] = obj.Q2MatForm(delta_q);
  
  p_shape = obj.P2MassShape(delta_p);
  
  r_shape = obj.R2Shape(delta_r);
  
  pr_shape = obj.ApplyP(r_shape,p_shape);
  pr_ann = obj.Shape2Ann(pr_shape);
  
  qpr_ann = obj.ApplyQ(pr_ann,A,t);
  
end

