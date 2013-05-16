function [pose_mu,pose_pc,pose_ev] = ComputePoseEigenspace(obj,shape)
  %ComputePoseEigenspace Summary of this function goes here
  %   Detailed explanation goes here

  [pose_mu,pc,ev] = obj.pca.Compute(shape);
  
  pose_pc = pc(:,1:obj.n_pose_pc);
  pose_ev = ev(1:obj.n_pose_pc);

end

