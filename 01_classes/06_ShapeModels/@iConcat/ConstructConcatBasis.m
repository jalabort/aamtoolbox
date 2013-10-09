function [U,PU] = ConstructConcatBasis(obj)
  %ConstructConcatBasis Summary of this function goes here
  %   Detailed explanation goes here

  U = [obj.GetSimBasis(),obj.GetPCs()];
  PU = pinv(U);
  
end



