function [variance] = ComputeLeftOutVariance(obj)
  %ComputeLeftOutVariance Summary of this function goes here
  %   Detailed explanation goes here

  variance = mean(obj.ev(obj.n_c+1:end));

end

