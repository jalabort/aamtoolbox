classdef (Abstract) F_Psc < F_2D & iU_Compositional
  %F_Aic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    dWdp
    Jt
  end
  
  methods
    function obj = F_Psc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

