classdef (Abstract) F_Cfc < F_2D & iU_Compositional
  %F_Cic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Cfc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

