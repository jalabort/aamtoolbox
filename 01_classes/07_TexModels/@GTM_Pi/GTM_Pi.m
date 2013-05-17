classdef GTM_Pi < GTM
  %GTM_Pi Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_Cent();
    n_ch_features = 1; 
  end
  
  methods
    function obj = GTM_Pi(img,rf,smoother)
      obj@GTM(img,rf,smoother);
    end
  end

end

