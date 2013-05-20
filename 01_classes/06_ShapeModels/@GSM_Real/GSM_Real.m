classdef (Abstract) GSM_Real < GSM
  %GSM_Real Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_Cent();
  end
  
  methods
    function obj = GSM_Real(ann)
      obj@GSM(ann);
    end
  end
  
end

