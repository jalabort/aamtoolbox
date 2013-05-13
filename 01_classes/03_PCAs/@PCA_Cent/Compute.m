function [mu,pc,ev] = Compute(data)
  %Compute Summary of this function goes here
  %   Detailed explanation goes here

  n_data = size(data,2);
  
  mu = mean(data,2);
  cent_data = data - repmat(mu,[1,n_data]);

  [pc,ev] = myGPCA(cent_data,n_data,0,0);   
  
end