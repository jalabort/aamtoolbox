classdef (Abstract) GSM_Complex_NonCent < GSM
  %GSM_Complex_NonCent Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
  end
  
  methods
    function obj = GSM_Complex_NonCent(ann)
      obj@GSM(ann);
    end
  end
  
end

