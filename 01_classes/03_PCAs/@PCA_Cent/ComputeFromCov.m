function [pc,ev] = ComputeFromCov(sigma,data)
  %COMPUTEFROMCOV Summary of this function goes here
  %   Detailed explanation goes here
  
  d1 = size(data,1);
  n_data = size(sigma,2);
  
  [pc,ev] = myGPCA2(sigma,n_data,0,0);   
  
  d2 = size(pc,1);
  
  if d1 > d2
    pc = data * pc * diag(ev.^(-1/2));
  end
  
end
