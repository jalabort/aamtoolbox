function [sim_basis,pc,ev] = OrthonormalizeBasis(obj)
%OrthonormalizeBasis Summary of this function goes here
%   Detailed explanation goes here

  [Q,~] = qr([obj.sim_basis,obj.pc],0);
  sim_basis = Q(:,1:obj.n_sim_basis);
  limit = min(obj.n_sim_basis+obj.n_pc,size(Q,1));
  pc = Q(:,obj.n_sim_basis+1:limit);
  ev = obj.ev(1:limit-obj.n_sim_basis);

end

