function [data] = Coeff2Data(~,pc,coeff)
  %COEFF2DATA Summary of this function goes here
  %   Detailed explanation goes here

  data = pc(:,1:length(coeff)) * coeff;
  
end

