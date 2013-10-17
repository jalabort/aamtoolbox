classdef GTM_NonCent < GTM
  %GTM_NonCent Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
  end
  
  methods
    function obj = GTM_NonCent(img,rf,Lp)
      obj@GTM(img,rf,Lp);
    end
  end

end

