classdef F_DaicSsd < F_2D
  %F_DAICSSD Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dw_dq
    dw_dpr
  end
  
  methods
    function obj = F_DaicSsd(f)
      obj = obj@F_2D(f);
    end
    
    obj = PreCompute(obj,level)
    [delta,c] = Optimize(obj,level,tex,c)
  end
  
end

