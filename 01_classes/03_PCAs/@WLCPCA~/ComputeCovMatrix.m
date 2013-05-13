function [sigma] = ComputeCovMatrix(data,n_data)
  %COMPUTECOVMATRIX Summary of this function goes here
  %   Detailed explanation goes here

  mu = mean(data,2);
  data = data - repmat(mu,[1,n_data]);

  if size(data, 1)<size(data, 2)
    sigma = data*(data');
  else
    sigma = (data'*data);
  end
  
end

