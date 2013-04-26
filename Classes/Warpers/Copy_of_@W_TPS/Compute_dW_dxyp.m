function [dW_dxyp] = Compute_dW_dxyp(obj,ann,A)
  %COMPUTE_DW_DXYP Summary of this function goes here
  %   Detailed explanation goes here
  
  U = obj.GetWeights(ann);
  
  s = zeros(obj.refFrame.nVert,2,obj.refFrame.nVert);
  r = zeros(obj.refFrame.nVert,obj.refFrame.nVert);
  for j = 1:obj.refFrame.nVert
    s(:,:,j) = obj.refFrame.tc - repmat(obj.refFrame.tc(j,:),[obj.refFrame.nVert,1]);
    r(:,j) = sqrt(sum(s(:,:,j).^2,2));
  end
  
  dW_dxyp = zeros(obj.refFrame.nVert,2,2);
  for j = 1:obj.refFrame.nVert
    mask = r(:,j) == 0;
    K = 2 * (1 + log(r(:,j).^2));
    K(mask) = 0;
    aux = U' * ([repmat(K,[1,2]) .* s(:,:,j); 0 0; 1 0; 0 1]) * A;
    dW_dxyp(j,1,:) =  [aux(1,1),aux(1,2)];
    dW_dxyp(j,2,:) =  [aux(2,1),aux(2,2)];
  end

end

