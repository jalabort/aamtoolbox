classdef GTM_Pi_Norm < GTM_Pi
  %GTM_Pi_Norm Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = GTM_Pi_Norm(img,rf,smoother,Lp)
      obj@GTM_Pi(img,rf,smoother,Lp);
    end
  end

end

