function [coeff] = Data2Coeff(MU,PC,data)
  %DATA2COEFF Summary of this function goes here
  %   Detailed explanation goes here
  
  U1 = PC(:,1:end/2);
  U2 = PC(:,1+end/2:end);
  
  coeff = U1'*data + U2.'*conj(data);
  
end

