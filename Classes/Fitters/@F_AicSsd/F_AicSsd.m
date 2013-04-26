classdef F_AicSsd < F_2D
  %F_PICECC Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dw_dp
  end
  
  methods
    function obj = F_AicSsd(f)
      obj = obj@F_2D(f);
    end
    
    obj = PreCompute(obj,level)
    [delta,c,H,ecc] = Optimize(obj,level,tex,c)
  end
  
end

