classdef CPCA_WLM < PCA
  %CKPCA_WLM Summary of this class goes here
  %   Detailed explanation goes here
  
  methods (Static)
    [dataMU,dataPC,dataEV,nDim] = Compute(data,nData)
    [coeff] = Data2Coeff(MU,PC,data)
    [data] = Coeff2Data(MU,PC,coeff)
  end
  
end

