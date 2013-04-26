classdef F_AicEcc < F_2D
  %F_AICECC Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dw_dp
  end
  
  methods
    function obj = F_AicEcc(f)
      obj = obj@F_2D(f);
    end
    
    obj = PreCompute(obj,level)
    [delta,c] = Optimize(obj,level,tex,c)
  end
  
end

