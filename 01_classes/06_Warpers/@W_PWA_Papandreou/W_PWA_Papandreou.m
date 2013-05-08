classdef W_PWA_2 < W_PWA
  %W_PWA_2 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
  end
  
  methods
    function obj = W_PWA_2(warper)
      obj = obj@W_PWA(warper.rf,warper.tri,warper.n_tri,warper.interp);
    end
    
    dw_dxyp = ComputeDWDXYQPR(obj,A)
    [qpr_ann,q,p,r] = UpdateAnn(obj,sm,~,delta,q,p,r,H)
  end
  
end

