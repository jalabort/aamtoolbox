function [coeff] = Data2Coeff(MU,PC,data)
  %DATA2COEFF Summary of this function goes here
  %   Detailed explanation goes here

  coeff = PC' * (data - MU);
  
end

