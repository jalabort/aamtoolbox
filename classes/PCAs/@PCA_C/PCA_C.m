classdef PCA_C < PCA
  %PCA_C Summary of this class goes here
  %   Detailed explanation goes here
  
  methods (Static)
    [dataMU,dataPC,dataEV,nDim] = Compute(data,nData)
    [dataMU] = ComputeCovMatrix(data,nData)
    [dataPC,dataEV,nDim] = ComputeFromCov(data,nData)
    [coeff] = Data2Coeff(MU,PC,data)
    [data] = Coeff2Data(MU,PC,coeff)
  end
  
end

