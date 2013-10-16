classdef (Abstract) PF_Bc < F_2D & iU_Compositional & handle
  %PF_Fc Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    dWdp
    Jt
  end
  
  methods
    function obj = PF_Bc(f)
      obj = obj@F_2D(f);
    end
  end
  
end

