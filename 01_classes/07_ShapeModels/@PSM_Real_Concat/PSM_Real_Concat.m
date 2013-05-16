classdef PSM_Real_Concat < PSM_Real & Interface_Concat
  %PSM_Real_Concat Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = PSM_Real_Concat(ann,part)
      obj@PSM_Real(ann,part);
      obj = obj@Interface_Concat();
    end
  end
  
end

