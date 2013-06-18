function [shape] = ApplyP(obj,p,shape)
  %ApplyP Summary of this function goes here
  %   Detailed explanation goes here

  shape = shape + obj.U(:,1:obj.n_p) * p;
  
end



