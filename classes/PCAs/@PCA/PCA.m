classdef (Abstract) PCA
  %PCA Summary of this class goes here
  %   Detailed explanation goes here
  
  methods (Static)
    [mu,pc,ev,n_dim] = Compute(data,n_data)
    
    [cov] = ComputeCovMatrix(data,n_data)
    [pc,ev,n_dim] = ComputeFromCov(cov,n_data)
    
    [coeff] = Data2Coeff(mu,pc,data)
    [data] = Coeff2Data(mu,pc,coeff)
  end
  
end

