classdef F_Aic_Lp < F_Aic
  %F_Aic_Ssd Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Lp
  end
  
  methods
    function obj = F_Aic_Lp(f, Lp)
      obj = obj@F_Aic(f);
      obj.Lp = Lp;
    end
  end
  
end

