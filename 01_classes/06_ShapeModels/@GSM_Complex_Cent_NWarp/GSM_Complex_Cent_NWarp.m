classdef GSM_Complex_Cent_NWarp < GSM_Complex_Cent & Interface_NWarp
  %GSM_Complex_Cent_NWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = GSM_Complex_Cent_NWarp(ann)
      obj@GSM_Complex_Cent(ann);
      [obj.sim_basis,obj.pc,obj.ev] = obj.OrthonormalizeBasis();
      obj.n_pc = size(obj.pc,2);
      obj.n_b = obj.n_pc;
      obj.n_p = obj.n_q + obj.n_b;
    end
  end
  
end

