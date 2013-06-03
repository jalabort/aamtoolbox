function [coeff] = Data2Coeff(~,pc,data)
  %Data2Coeff Summary of this function goes here
  %   Detailed explanation goes here

  coeff = pc' * data;
  
end

