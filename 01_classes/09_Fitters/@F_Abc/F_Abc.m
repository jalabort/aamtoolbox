classdef (Abstract) F_Abc < F_2D & iU_Compositional & handle
  %F_Aic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Abc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

