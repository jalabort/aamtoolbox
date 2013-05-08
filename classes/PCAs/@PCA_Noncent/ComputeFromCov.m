function [pc,ev,n_dim] = ComputeFromCov(sigma,n_data)
  %COMPUTEFROMCOV Summary of this function goes here
  %   Detailed explanation goes here

  [pc,ev] = myGPCA2(sigma,n_data,0,0);   
  n_dim = length(ev);
  
end

