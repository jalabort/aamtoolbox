classdef (Abstract) CSM_Real < CSM
  %CSM_Real Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sim_pca = PCA_Cent();
    pca = PCA_Cent();
  end
  
  methods
    function obj = CSM_Real(ann,part)
      obj@CSM(ann,part);
    end
  end
  
end

