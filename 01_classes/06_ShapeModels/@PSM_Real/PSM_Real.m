classdef (Abstract) PSM_Real < PSM
  %PSM_Real Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sim_pca = PCA_Cent();
    pca = PCA_Cent();
  end
  
  methods
    function obj = PSM_Real(ann,part)
      obj@PSM(ann,part);
    end
  end
  
end

