classdef F_DaicEcc < F_2D
  %F_DAICECC Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dw_dqp
    dw_dr
  end
  
  methods
    function obj = F_DaicEcc(f)
      obj = obj@F_2D(f);
    end
    
    obj = PreCompute(obj,level)
    [delta,c] = Optimize(obj,level,tex,c)
  end
  
end

