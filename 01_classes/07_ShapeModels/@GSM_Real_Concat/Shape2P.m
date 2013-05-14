function [p] = Shape2P(obj,shape)
  %Shape2P Summary of this function goes here
  %   Detailed explanation goes here

  p =  obj.PU * (shape - obj.mu);
  
end



