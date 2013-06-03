function [shape] = B2Shape(obj,b)
  %B2Shape Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.pca.Coeff2Data(obj.mu,obj.pc(:,1:obj.n_b),b);

end

