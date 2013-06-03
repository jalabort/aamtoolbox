function [coeff] = Data2Coeff(mu,pc,data)
  %Data2Coeff Summary of this function goes here
  %   Detailed explanation goes here

  coeff = pc' * (data - repmat(mu,[1,size(data,2)]));
  
end