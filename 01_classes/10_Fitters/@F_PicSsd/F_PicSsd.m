classdef F_PicSsd < F_2D
  %F_PICECC Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    g
    inv_q
  end
  
  methods
    function obj = F_PicSsd(f)
      obj = obj@F_2D(f);
    end
    
    obj = PreCompute(obj,level)
    [delta,c] = Optimize(obj,level,tex,c)
  end
  
end

