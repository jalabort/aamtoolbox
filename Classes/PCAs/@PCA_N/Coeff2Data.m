function [data] = Coeff2Data(MU,PC,coeff)
  %COEFF2DATA Summary of this function goes here
  %   Detailed explanation goes here

  data = PC(:,1:length(coeff)) * coeff;
  
end

