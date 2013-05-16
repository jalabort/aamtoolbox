function [shape] = F2Shape(obj,f)
  %F2Shape Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.pca.Coeff2Data(obj.mass_mu,obj.mass_pc,f);
  
end

