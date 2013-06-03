classdef W_PWA_Baker < W_PWA & iC_Baker
  %W_PWA_Baker Summary of this class goes here
  %   Detailed explanation goes here

  methods
    function obj = W_PWA_Baker(w)
      obj = obj@W_PWA(w.rf,w.tri,w.interp);
    end
    
    [cann] = WoW(obj,mu_ann,qpr_ann,ann)
  end
  
end

