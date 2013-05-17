function [dWdu_qpr] = Compute_dWdu_uqpr(obj,A,~)
  %Compute_dWdu_uqpr Summary of this function goes here
  %   Detailed explanation goes here

  dWdu_qpr = zeros(obj.rf.n_vert,2,2);
 
  aux = [1,0;0,1] * A; 
  dWdu_qpr(:,1,:) = repmat([aux(1,1),aux(1,2)],[obj.rf.n_vert 1]);
  dWdu_qpr(:,2,:) = repmat([aux(2,1),aux(2,2)],[obj.rf.n_vert 1]);

end

