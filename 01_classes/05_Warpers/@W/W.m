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
    
    ann = DensifyDSAnn(obj,ds)
    
    dWduvi = Compute_dWduvi(obj)
    
    [xy,uv] = Compute_Wuv(obj,ann,res)
    
    wimg = WarpDense(obj,ann,img)
    wimg = WarpSparse(obj,ann,img)
    
    wimg = WarpDenseDS(obj,ds,ann)
    wimg = WarpSparseDS(obj,ds)
  end
  
  methods (Static)
    Save(img,opt,i)
    [img,loaded] = Load(opt,i)
  end
  
end

