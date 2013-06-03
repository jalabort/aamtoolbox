classdef (Abstract) PF_Fc < F_2D & iU_Compositional
  %PF_Fc Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    dWdp
  end
  
  methods
    function obj = PF_Fc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

