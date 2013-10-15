classdef (Abstract) F_Pfc < F_2D & iU_Compositional & handle
  %F_Aic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    dWdp
  end
  
  methods
    function obj = F_Pfc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

