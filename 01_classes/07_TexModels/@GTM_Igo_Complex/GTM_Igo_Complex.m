classdef GTM_Igo_Complex < GTM
  %GTM_Igo_Complex Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
    n_ch_features = 1;
  end
    
  methods
    function obj = GTM_Igo_Complex(img,rf,smoother)
      obj@GTM(img,rf,smoother);
    end
  end

end

