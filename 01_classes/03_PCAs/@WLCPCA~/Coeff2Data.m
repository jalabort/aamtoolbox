function [data] = Coeff2Data(MU,PC,coeff)
  %COEFF2DATA Summary of this function goes here
  %   Detailed explanation goes here

  nCoeff = length(coeff);
  
  U1 = PC(:,1:end/2);
  U2 = PC(:,1+end/2:end);
  
  data = U1(:,1:nCoeff)*coeff + U2(:,1:nCoeff)*coeff;
  
end

