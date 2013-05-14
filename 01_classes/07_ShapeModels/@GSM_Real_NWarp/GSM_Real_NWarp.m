classdef GSM_Real_NWarp < GSM_Real
  %GSM_Real_NWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = GSM_Real_NWarp(ann)
      obj@GSM_Real(ann);
      [obj.sim_basis,obj.pc] = obj.OrthonormalizeBasis();
    end
    
    [sim_basis,pc] = OrthonormalizeBasis(obj);
    
    b = Shape2B(obj,shape)
    shape = B2Shape(obj,b)
    
    q = Shape2Q(obj,shape)
    shape = Q2Shape(obj,q)
  end
  
end

