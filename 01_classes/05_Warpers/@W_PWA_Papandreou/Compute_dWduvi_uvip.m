function [dWduvi_uvip] = Compute_dWduvi_uvip(obj,A,~)
  %Compute_dWduvi_uvip Summary of this function goes here
  %   Detailed explanation goes here

  dWduvi_uvip = zeros(obj.rf.n_vert,2,2);
 
  aux = [1,0;0,1] * A; 
  dWduvi_uvip(:,1,:) = repmat([aux(1,1),aux(1,2)],[obj.rf.n_vert 1]);
  dWduvi_uvip(:,2,:) = repmat([aux(2,1),aux(2,2)],[obj.rf.n_vert 1]);

end

