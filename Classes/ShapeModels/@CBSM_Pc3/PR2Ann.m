function [pr_ann,p,r] = PR2Ann(obj,pr)
  %PR2ANN Summary of this function goes here
  %   Detailed explanation goes here

  p = pr(1:obj.n_p);
  
  s = obj.n_p+1;
  r = cell(obj.n_comp,1);
  for i = 1:obj.n_comp
    e = s + obj.n_r(i) - 1;
    r{i} = pr(s:e);
    s = e + 1;
  end

  r_shape = obj.R2Shape(r);
  
  p_shape = obj.P2MassShape(p);
  pr_shape = obj.ApplyP(r_shape,p_shape);
  
  pr_ann = obj.Shape2Ann(pr_shape);
  
end



