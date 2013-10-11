classdef GTM_Igo_Real_Double < GTM
  %GTM_Igo Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
    n_ch_features = 4;
  end
  
  methods
    function obj = GTM_Igo_Real_Double(img,rf,smoother,Lp)
      obj@GTM(img,rf,smoother,Lp);
    end
  end

end

