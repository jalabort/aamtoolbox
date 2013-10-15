classdef (Abstract) F_Pic < F_2D & iU_Compositional & handle
  %F_Aic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    J
    invH
  end
  
  methods
    function obj = F_Pic(f)
      obj = obj@F_2D(f);
    end
  end
  
end

