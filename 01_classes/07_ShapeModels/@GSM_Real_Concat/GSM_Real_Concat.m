classdef GSM_Real_Concat < GSM_Real
  %GSM_Real_Concat Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    U
    PU
  end
  
  methods
    function obj = GSM_Real_Concat(ann)
      obj@GSM_Real(ann);
      [obj.U,obj.PU] = ConstructConcatBasis();
    end
    
  end
  
end

