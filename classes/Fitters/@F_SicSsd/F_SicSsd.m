classdef F_SicSsd < F_2D
  %SICECCFITTER Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dw_dp
  end
  
   methods
    function obj = F_SicSsd(f)
      obj = obj@F_2D(f);
    end
    
    obj = PreCompute(obj,level)
    [delta,c] = Optimize(obj,level,tex,c)
  end
  
end

