classdef GSM_Complex_Cent_Concat < GSM_Complex_Cent & iConcat
  %GSM_Complex_Cent_Concat Summary of this class goes here
  %   Detailed explanation goes here

  methods
    function obj = GSM_Complex_Cent_Concat(ann)
      obj@GSM_Complex_Cent(ann);
      obj = obj@iConcat();
    end
  end
  
end

