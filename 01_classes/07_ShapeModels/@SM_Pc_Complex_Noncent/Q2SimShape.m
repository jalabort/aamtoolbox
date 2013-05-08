function [sShape] = Q2SimShape(obj,q)
  %Q2SImSHAPE Summary of this function goes here
  %   Detailed explanation goes here

  sShape = obj.simMU + obj.simBasis(:,1:length(q)) * q;
  
end

