classdef (Abstract) iConcat
  %iConcat Summary of this class goes here
  %   Detailed explanation goes here

  properties
    U
    PU
  end
  
  methods
    function obj = iConcat()
      [obj.U,obj.PU] = obj.ConstructConcatBasis();
    end
    
    [U,PU] = ConstructConcatBasis(obj);
    [sim_basis] = GetSimBasis(obj)
    [pc] = GetPCs(obj)
  end
  
end

