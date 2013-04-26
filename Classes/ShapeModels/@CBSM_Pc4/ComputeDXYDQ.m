function [dx_dq,dy_dq] = ComputeDXYDQ(obj)
  %COMPUTEDXYDQ Summary of this function goes here
  %   Detailed explanation goes here

  [dx_dq,dy_dq] = obj.Shape2XY(obj.sim_basis(:,1:obj.n_q));

end

