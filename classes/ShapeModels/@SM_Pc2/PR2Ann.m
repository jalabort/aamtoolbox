function [p_ann,p,r] = PR2Ann(obj,pr)
  %PR2ANN Summary of this function goes here
  %   Detailed explanation goes here

  p = pr(1:obj.n_p);
  r = [];
  
  p_shape = obj.P2Shape(pr);
  p_ann = obj.Shape2Ann(p_shape);
  
end



