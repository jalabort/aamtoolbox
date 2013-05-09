function [mu,pc,ev] = Compute(data)
  %COMPUTE Summary of this function goes here
  %   Detailed explanation goes here

  n_data = size(data,2);
  [pc,ev] = myGPCA(data,n_data,0,0);   
  
  mu = [];
  
end

