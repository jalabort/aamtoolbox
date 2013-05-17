classdef F_Aic_Ssd < F_Aic
  %F_Aic_Ssd Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Aic_Ssd(f)
      obj = obj@F_Aic(f);
    end
  end
  
end

