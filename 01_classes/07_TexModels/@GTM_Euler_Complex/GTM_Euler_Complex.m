classdef GTM_Euler_Complex < GTM
  %GTM_Euler_Complex Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    pca = PCA_NonCent();
    n_ch_features = 1;
    alpha_pi = 1.9 * pi;
  end
  
  methods
    function obj = GTM_Euler_Complex(img,rf,smoother,alpha)
      obj@GTM(img,rf,smoother);
      if nargin > 3  &&  ~isempty(alpha) 
        obj.alpha_pi = alpha * pi;
      end
    end
  end

end

