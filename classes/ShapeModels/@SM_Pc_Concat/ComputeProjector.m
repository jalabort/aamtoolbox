function [P] = ComputeProjector(obj)
  %COMPUTEPROJECTOR Summary of this function goes here
  %   Detailed explanation goes here

  basis = [obj.sim_basis,obj.pc(:,1:obj.n_p)];
  P = (basis' * basis) \ basis';
  
end



