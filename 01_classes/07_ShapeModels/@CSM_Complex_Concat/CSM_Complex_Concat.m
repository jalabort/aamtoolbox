classdef CSM_Complex_Concat < CSM_Complex & Interface_Concat
  %CSM_Complex_Concat Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = CSM_Complex_Concat(ann,part)
      obj@CSM_Complex(ann,part);
      obj = obj@Interface_Concat();
    end
  end
  
end

