function [MU,PC,EV,nDim] = Compute(data,nData)
  %COMPUTE Summary of this function goes here
  %   Detailed explanation goes here

  MU = mean(data,2);
  centData = data - repmat(MU,[1,nData]);

  [PC,EV] = myGPCA(centData,nData,0,0);   
  nDim = length(EV);
  
end

