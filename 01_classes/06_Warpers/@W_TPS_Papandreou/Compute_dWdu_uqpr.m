function [dWdu_qpr] = Compute_dWdu_uqpr(obj,A,ann)
  %Compute_dWdu_uqpr Summary of this function goes here
  %   Detailed explanation goes here
  
  U = obj.GetWeights(ann);
  
  dWdu_qpr = zeros(obj.rf.n_vert,2,2);
  
  for i = 1:obj.rf.n_vert
    aux = U' * ([repmat(obj.dKdxy{i},[1,2]) .* ... 
      squeeze(obj.s(:,i,:));0 0;1 0;0 1]) * A;
    dWdu_qpr(i,1,:) = [aux(1,1),aux(1,2)];
    dWdu_qpr(i,2,:) = [aux(2,1),aux(2,2)];
  end

end

