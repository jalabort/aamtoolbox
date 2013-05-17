classdef GTM_Euler < GTM
  %GTM_Euler Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
    n_ch_features = 2;
    alpha_pi = 1.9 * pi;
  end
  
  methods
    function obj = GTM_Euler(img,rf,smoother,alpha)
      obj@GTM(img,rf,smoother);
      if ~isempty(alpha)
        obj.alpha_pi = alpha * pi;
      end
    end
  end

end

