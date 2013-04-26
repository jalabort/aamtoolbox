function [MU,PC,EV,nDim] = Compute(data,nData)
  %COMPUTE Summary of this function goes here
  %   Detailed explanation goes here
  
  MU = [];
  [PC, EV] = myGPCA(data,nData,0,0);    
  nDim = length(EV);

end

