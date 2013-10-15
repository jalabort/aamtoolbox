classdef (Abstract) F_Csc < F_2D & iU_Compositional & handle
  %F_Cic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Csc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

