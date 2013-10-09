classdef GTM_Gi_Real < GTM
  %GTM_Gi_Real Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_Cent();
    n_ch_features = 2; 
  end
  
  methods
    function obj = GTM_Gi_Real(img,rf,smoother)
      obj@GTM(img,rf,smoother);
    end
  end

end

