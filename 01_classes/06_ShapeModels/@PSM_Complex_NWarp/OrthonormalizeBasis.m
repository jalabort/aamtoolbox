function [sim_basis,pose_pc,pose_ev] = OrthonormalizeBasis(obj)
%OrthonormalizeBasis Summary of this function goes here
%   Detailed explanation goes here

  [Q,~] = qr([obj.sim_basis,obj.pose_pc],0);
  sim_basis = Q(:,1:obj.n_sim_basis);
  limit = min(obj.n_sim_basis+obj.n_pose_pc,size(Q,1));
  pose_pc = Q(:,obj.n_sim_basis+1:limit);
  pose_ev = obj.pose_ev(1:limit-obj.n_sim_basis);

end

