classdef (Abstract) F_Cbc < F_2D & iU_Compositional
  %F_Cic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Cbc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

