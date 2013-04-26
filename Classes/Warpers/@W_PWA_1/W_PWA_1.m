classdef W_PWA_1 < W_PWA
  %W_PWA_1 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function obj = W_PWA_1(w)
      obj = obj@W_PWA(w.rf,w.tri,w.n_tri,w.interp);
    end
    
    [cann] = ComposeWarp(obj,mu_ann,qpr_ann,ann)
    [qpr_ann,q,p,r] = UpdateAnn(obj,sm,ann,delta,q,p,r,H)
  end
  
end

