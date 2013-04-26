function [dw_dxyp] = ComputeDWDXYQPR(obj,A)
  %COMPUTEDWDXYQPR Summary of this function goes here
  %   Detailed explanation goes here

  dw_dxyp = zeros(obj.rf.n_vert,2,2);
  
  aux = [1,0;0,1];
  aux = aux * A;
  
  dw_dxyp(:,1,:) = repmat([aux(1,1),aux(1,2)],[obj.rf.n_vert 1]);
  dw_dxyp(:,2,:) = repmat([aux(2,1),aux(2,2)],[obj.rf.n_vert 1]);

end

