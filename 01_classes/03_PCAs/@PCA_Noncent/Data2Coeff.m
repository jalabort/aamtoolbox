function [coeff] = Data2Coeff(~,pc,data)
  %DATA2COEFF Summary of this function goes here
  %   Detailed explanation goes here

  coeff = pc' * data;
  
end

