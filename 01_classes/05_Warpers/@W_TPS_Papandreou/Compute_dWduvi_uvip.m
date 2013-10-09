function [dWduvi_uvip] = Compute_dWduvi_uvip(obj,A,ann)
  %Compute_dWduvi_uvip Summary of this function goes here
  %   Detailed explanation goes here
  
  U = obj.GetWeights(ann);
  
  dWduvi_uvip = zeros(obj.rf.n_vert,2,2);
  
  for i = 1:obj.rf.n_vert
    aux = U' * ([repmat(obj.dKdxy{i},[1,2]) .* ... 
      squeeze(obj.s(:,i,:));0 0;1 0;0 1]) * A;
    dWduvi_uvip(i,1,:) = [aux(1,1),aux(1,2)];
    dWduvi_uvip(i,2,:) = [aux(2,1),aux(2,2)];
  end

end

