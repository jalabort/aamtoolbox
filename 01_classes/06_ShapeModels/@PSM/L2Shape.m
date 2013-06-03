function [shape] = L2Shape(obj,l)
  %L2Shape Summary of this function goes here
  %   Detailed explanation goes here

  shape = obj.pca.Coeff2Data(obj.pose_mu,obj.pose_pc(:,1:obj.n_l),l);
  
end

