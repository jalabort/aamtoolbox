function [simBasis,nSimDim] = ComputeGlobalSimBasis(obj)
  %COMPUTESIMILARITYBASIS Summary of this function goes here
  %   Detailed explanation goes here

  nSimDim = 4;
  nVert2 = 2*obj.nVert;
  simBasis = zeros(nVert2,nSimDim);
  
  muAnn = obj.SimShape2Ann(obj.simMU);
  muX = muAnn(:,1);
  muY = muAnn(:,2);
  one = ones(obj.nVert,1);
  zero = zeros(obj.nVert,1);

  simBasis(:,1) = [muX;muY];
  simBasis(:,2) = [-muY;muX];
  simBasis(:,3) = [one;zero];
  simBasis(:,4) = [zero;one];

end

