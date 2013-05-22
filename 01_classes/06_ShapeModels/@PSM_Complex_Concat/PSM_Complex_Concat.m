classdef PSM_Complex_Concat < PSM_Complex & iConcat
  %PSM_Complex_Concat Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = PSM_Complex_Concat(ann,part)
      obj@PSM_Complex(ann,part);
      obj = obj@iConcat();
    end
  end
  
end

