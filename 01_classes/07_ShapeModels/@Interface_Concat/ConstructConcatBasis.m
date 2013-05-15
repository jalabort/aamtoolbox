function [U,PU] = ConstructConcatBasis(obj)
  %ConstructConcatBasis Summary of this function goes here
  %   Detailed explanation goes here

  U = [obj.sim_basis(:,1:obj.n_q),obj.pc(:,1:obj.n_b)];
  PU = (U' * U) \ U';
  
end



