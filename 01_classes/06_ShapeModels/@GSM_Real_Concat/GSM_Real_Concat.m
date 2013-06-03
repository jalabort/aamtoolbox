classdef GSM_Real_Concat < GSM_Real & iConcat
  %GSM_Real_Concat Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = GSM_Real_Concat(ann)
      obj@GSM_Real(ann);
      obj = obj@iConcat();
    end
  end
  
end

