classdef (Abstract) PF_Ic < F_2D & iU_Compositional
  %PF_FI Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    J
    H
  end
  
  methods
    function obj = PF_Ic(f)
      obj = obj@F_2D(f);
    end
  end
  
end

