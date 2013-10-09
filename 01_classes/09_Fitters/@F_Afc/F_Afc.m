classdef (Abstract) F_Afc < F_2D & iU_Compositional
  %F_Aic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Afc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

