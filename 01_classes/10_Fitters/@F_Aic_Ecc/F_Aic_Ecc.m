classdef F_Aic_Ecc < F_Aic
  %F_Aic_Ecc Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dWdp
  end
  
  methods
    function obj = F_Aic_Ecc(f)
      obj = obj@F_Aic(f);
    end
  end
  
end

