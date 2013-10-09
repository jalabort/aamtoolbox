function [shape] = ApplyB(obj,b,shape)
  %ApplyB Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.pca.Coeff2Data(shape,obj.pc(:,1:obj.n_b),b);

end

