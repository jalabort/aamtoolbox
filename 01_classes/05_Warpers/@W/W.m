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
    
    dWduvi = Compute_dWduvi(obj)
    
    [xy,uv] = Compute_Wuv(obj,ann,res);
    wimg = Warp(obj,ann,img)
    wimg = WarpDS(obj,ds)
  end
  
end

