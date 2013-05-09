classdef (Abstract) PCA
  %PCA Summary of this class goes here
  %   Detailed explanation goes here
  
  methods (Static)
    [mu,pc,ev] = Compute(data)
    
    cov = ComputeCovMatrix(data)
    [pc,ev] = ComputeFromCov(cov,data)
    
    coeff = Data2Coeff(mu,pc,data)
    data = Coeff2Data(mu,pc,coeff)
  end
  
end

