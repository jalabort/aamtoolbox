function [variance] = ComputeLeftOutVariance(obj)
  %ComputeLeftOutVariance Summary of this function goes here
  %   Detailed explanation goes here

  variance = (1 / (obj.n_pc - obj.n_c)) * sum(obj.ev(obj.n_c+1:end));

end

