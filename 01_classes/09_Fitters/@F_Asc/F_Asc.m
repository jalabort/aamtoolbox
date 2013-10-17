classdef (Abstract) F_Asc < F_2D & iU_Compositional & handle
  %F_Aic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Asc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

