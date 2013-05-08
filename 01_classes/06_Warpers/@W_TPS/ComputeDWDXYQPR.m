function [dW_dxyp] = ComputeDWDXYQPR(obj,A,ann)
  %COMPUTEDWDXYQPR Summary of this function goes here
  %   Detailed explanation goes here
  
  U = obj.GetWeights(ann);
  
  dW_dxyp = zeros(obj.rf.n_vert,2,2);
  
  for j = 1:obj.rf.n_vert
    mask = obj.r(:,j) == 0;
    dK_dxy = 2 * (1 + log(obj.r(:,j).^2));
    dK_dxy(mask) = 0;
    aux = U' * ([repmat(dK_dxy,[1,2]) .* squeeze(obj.s(:,j,:)); 0 0; 1 0; 0 1]) * A;
    dW_dxyp(j,1,:) =  [aux(1,1),aux(1,2)];
    dW_dxyp(j,2,:) =  [aux(2,1),aux(2,2)];
  end

end

