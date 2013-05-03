function [shape] = P2Shape(obj,p)
  %P2SHAPE Summary of this function goes here
  %   Detailed explanation goes here

  [shape] = obj.pca.Coeff2Data(obj.mu,obj.pc,p);

end

