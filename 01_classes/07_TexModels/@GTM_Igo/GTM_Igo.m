classdef GTM_Igo < GTM
  %GTM_Igo Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
    n_ch_features = 2; 
  end
  
  methods
    function obj = GTM_Igo(img,rf,smoother)
      obj@GTM(img,rf,smoother);
    end
  end

end

