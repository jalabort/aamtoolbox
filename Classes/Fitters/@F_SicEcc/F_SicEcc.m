classdef F_SicEcc< F_2D
  %F_SICECC Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dw_dp
  end
  
   methods
    function obj = F_SicEcc(f)
      obj = obj@F_2D(f);
    end
    
    obj = PreCompute(obj,level)
    [delta,c] = Optimize(obj,level,tex,c)
  end
  
end

