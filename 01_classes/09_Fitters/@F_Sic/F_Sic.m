classdef F_Sic < F_2D & iU_Compositional & handle
  %F_Sic Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
%     VxA
%     VyA
  end
  
  methods
    function obj = F_Sic(f)
      obj = obj@F_2D(f);
    end
  end
  
end

