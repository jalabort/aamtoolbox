function [data] = Coeff2Data(MU,PC,coeff)
  %Coeff2DataSummary of this function goes here
  %   Detailed explanation goes here

  data = MU + PC(:,1:length(coeff)) * coeff;
  
end