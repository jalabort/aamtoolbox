function [data] = Coeff2Data(~,pc,coeff)
  %Coeff2Data Summary of this function goes here
  %   Detailed explanation goes here

  data = pc(:,1:length(coeff)) * coeff;
  
end

