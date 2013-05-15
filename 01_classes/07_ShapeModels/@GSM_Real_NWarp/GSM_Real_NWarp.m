classdef GSM_Real_NWarp < GSM_Real & Interface_NWarp
  %GSM_Real_NWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = GSM_Real_NWarp(ann)
      obj@GSM_Real(ann);
      obj@Interface_NWarp();
    end
  end
  
end

