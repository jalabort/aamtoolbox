function [simMU,simBasis,nSimDim,PC] = ComputeGlobalSimBasis(obj,rAnn)
  %COMPUTESIMILARITYBASIS Summary of this function goes here
  %   Detailed explanation goes here

  simMU = rAnn;% 2 * (obj.PC(:,1) + obj.PC(:,1+end/2));
  nSimDim = 2;
  simBasis = zeros(obj.nVert,nSimDim);
  
  simBasis(:,1) = simMU;
  simBasis(:,2) = ones(obj.nVert,1);

  [Q,~] = qr(simBasis,0);
  simBasis = Q(:,1:nSimDim);
%   limit = min(nSimDim+obj.nDim,size(Q,1));
%   PC = Q(:,nSimDim+1:limit);
  PC = [];

end

