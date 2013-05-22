classdef CSM_Real_Concat < CSM_Real & iConcat
  %CSM_Real_Concat Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = CSM_Real_Concat(ann,part)
      obj@CSM_Real(ann,part);
      obj = obj@iConcat();
    end
  end
  
end

