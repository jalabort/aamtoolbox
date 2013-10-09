function [data] = Coeff2Data(mu,pc,coeff)
  %Coeff2Data Summary of this function goes here
  %   Detailed explanation goes here

  data = repmat(mu,[1,size(coeff,2)]) + pc(:,1:size(coeff,1)) * coeff;
  
end