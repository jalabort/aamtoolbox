function [MU,PC,EV,nDim] = Compute(data,nData)
  %COMPUTE Summary of this function goes here
  %   Detailed explanation goes here
  
  MU = [];
  
  rData = real(data);
  iData = imag(data);
  cData = [rData;iData];
  
  [PC,EV] = myGPCA(cData,nData,0,0);  
  nDim = length(EV);
  
  nFeatures = size(data,1);
  I = eye(nFeatures);
  Tf = (1/sqrt(2)) * [I,1j*I;I,-1j*I];
  
  PC = Tf * PC;
  
  nPC = size(PC,2);
  nCoeff = nPC/2;
  
  if mod(nPC,2) == 1 
    I2 = eye(floor(nCoeff));
    Tf2 = (1/sqrt(2)) * [I2,1j*I2;I2,-1j*I2];
    PC = PC(:,1:end-1) * Tf2';
  else
    I2 = eye(nCoeff);
    Tf2 = (1/sqrt(2)) * [I2,1j*I2;I2,-1j*I2];
    PC = PC(:,1:end) * Tf2';
  end
  
  PC = PC(1:end/2,:);
  
end

