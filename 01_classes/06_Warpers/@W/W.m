classdef (Abstract) W
  %W Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    rf
    interp
  end
  
  methods
    function obj = W(rf,interp)
      obj.rf = rf;
      obj.interp = interp;
    end
    
    dWdxi = Compute_dWdxi(obj)
    [qpr_ann,q,p,r] = UpdateAnn(sm,ann,delta,q,p,r)
    
    [Wxy,xy] = Compute_Wxy(obj,ann,res);
    wimg = Warp(obj,ann,img)
    wimg = WarpDS(obj,ds)
  end
  
end

