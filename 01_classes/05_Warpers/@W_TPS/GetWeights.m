function [W] = GetWeights(obj,ann)
  %GetWeights Summary of this function goes here
  %   Detailed explanation goes here
  
  T = [ann; zeros(3,2)];
  W = obj.invL * T;

end