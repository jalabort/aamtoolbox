classdef GSM_Complex_Concat < GSM_Complex & Interface_Concat
  %GSM_Complex Summary of this class goes here
  %   Detailed explanation goes here

  methods
    function obj = GSM_Complex_Concat(ann)
      obj@GSM_Complex(ann);
      obj = obj@Interface_Concat();
    end
  end
  
end

