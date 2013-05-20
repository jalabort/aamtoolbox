classdef (Abstract) GSM_Euler_Real < GSM_Euler
  %GSM_Euler_Real Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
  end
  
  methods
    function obj = GSM_Euler_Real(ann,alpha)
      obj@GSM_Euler(ann,alpha);
    end
  end
  
end

