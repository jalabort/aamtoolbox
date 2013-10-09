classdef (Abstract) GSM_Complex_Cent < GSM
  %GSM_Complex_Cent Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sim_pca = PCA_Cent();
    pca = PCA_Cent();
  end
  
  methods
    function obj = GSM_Complex_Cent(ann)
      obj@GSM(ann);
    end
  end
  
end

