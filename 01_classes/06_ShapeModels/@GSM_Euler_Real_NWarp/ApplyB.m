function [shape] = ApplyB(obj,b,shape)
  %ApplyB Summary of this function goes here
  %   Detailed explanation goes here

  eshape = obj.Shape2EShape(shape);
  eshape = obj.pca.Coeff2Data(eshape,obj.pc(:,1:obj.n_b),b);
  shape = obj.EShape2Shape(eshape);

end

