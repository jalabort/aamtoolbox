function [W] = GetWeights(obj,ann)
  %GETWEIGHTS Summary of this function goes here
  %   Detailed explanation goes here
  
  T = [ann; zeros(3,2)];
  W = obj.inv_L * T;

end