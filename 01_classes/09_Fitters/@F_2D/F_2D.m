classdef (Abstract) F_2D < M_2D
  %F_2D Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    detector
    n_it
  end
  
  methods
    function obj = F_2D(m)
      obj = obj@M_2D(m.n_level,m.w,m.sm,m.tm);
    end
    
    obj = Initialize(obj)
    fann = Fit(obj,img,ann)
  end
  
  methods (Abstract)
    obj = PreCompute(obj,level)
    [delta,c] = Optimize(obj,level,tex,c)
  end
  
end

