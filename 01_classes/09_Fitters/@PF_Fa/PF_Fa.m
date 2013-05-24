classdef (Abstract) PF_Fa < F_2D & iU_Additive
  %PF_Fa Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    t
    dWduv
  end
  
  methods
    function obj = PF_Fa(f)
      obj = obj@F_2D(f);
    end
  end
  
end

