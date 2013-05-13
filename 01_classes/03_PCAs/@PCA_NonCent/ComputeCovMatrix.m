function [sigma] = ComputeCovMatrix(data)
  %ComputeCovMatrix Summary of this function goes here
  %   Detailed explanation goes here

  if size(data, 1)<size(data, 2)
    sigma = data*(data');
  else
    sigma = (data'*data);
  end
  
end