function [coeff] = Data2Coeff(mu,pc,data)
  %DATA2COEFF Summary of this function goes here
  %   Detailed explanation goes here

  coeff = pc' * (data - mu);
  
end