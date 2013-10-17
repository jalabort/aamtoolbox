classdef GTM_Cent < GTM
  %GTM_Cent Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_Cent();
  end
  
  methods
    function obj = GTM_Cent(img,rf,Lp)
      obj@GTM(img,rf,Lp);
    end
  end

end

