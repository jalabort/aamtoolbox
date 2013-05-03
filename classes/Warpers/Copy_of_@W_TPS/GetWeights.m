function [W] = GetWeights(obj,ann)
  %GETWEIGHTS Summary of this function goes here
  %   Detailed explanation goes here
  
  r = zeros(obj.refFrame.nVert,obj.refFrame.nVert);
  for j = 1:obj.refFrame.nVert
    r(:,j) = sqrt(sum((obj.refFrame.tc - repmat(obj.refFrame.tc(j,:),[obj.refFrame.nVert,1])).^2,2));
  end
  
  mask = r == 0;
  K = r.^2 .* log(r.^2);
  K(mask) = 0;
  obj.L(1:end-3,1:end-3) = K;
  T = [ann; zeros(3,2)];
  W = obj.L \ T;

end