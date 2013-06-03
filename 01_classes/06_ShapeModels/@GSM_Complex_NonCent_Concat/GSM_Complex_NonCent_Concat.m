classdef GSM_Complex_NonCent_Concat < GSM_Complex_NonCent & iConcat
  %GSM_Complex_NonCent_Concat Summary of this class goes here
  %   Detailed explanation goes here

  methods
    function obj = GSM_Complex_NonCent_Concat(ann)
      obj@GSM_Complex_NonCent(ann);
      obj = obj@iConcat();
    end
  end
  
end

