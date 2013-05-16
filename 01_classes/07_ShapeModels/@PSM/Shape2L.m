function [l] = Shape2L(obj,shape)
  %Shape2L Summary of this function goes here
  %   Detailed explanation goes here

  l = obj.pca.Data2Coeff(obj.pose_mu,obj.pose_pc,shape);
  
end

