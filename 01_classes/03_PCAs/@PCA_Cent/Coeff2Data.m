function [data] = Coeff2Data(mu,pc,coeff)
  %Coeff2Data Summary of this function goes here
  %   Detailed explanation goes here

  data = mu + pc(:,1:length(coeff)) * coeff;
  
end