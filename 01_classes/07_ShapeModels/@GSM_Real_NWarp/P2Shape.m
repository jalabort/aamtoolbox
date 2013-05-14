function [shape] = P2Shape(obj,p)
  %Shape2P Summary of this function goes here
  %   Detailed explanation goes here

  q = p(1:n_q);
  b = p(n_q+1:end);
  
  shape = obj.ApplyQ(q,obj.B2Shape(b));

end



