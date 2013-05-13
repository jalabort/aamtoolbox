classdef SM_Pc_NWarp < SM_Pc
  %SM_Pc_NWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = SM_Pc_NWarp(ann)
      obj@SM_Pc(ann,;
      
       [obj.sim_basis,obj.pc] = obj.OrthonormalizeBasis();
    end
    
    [sim_basis,pc] = OrthonormalizeBasis(obj);

  end
  
end

