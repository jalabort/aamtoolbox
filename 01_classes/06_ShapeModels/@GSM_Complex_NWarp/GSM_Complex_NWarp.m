classdef GSM_Complex_NWarp < GSM_Complex & Interface_NWarp
  %GSM_Complex Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = GSM_Complex_NWarp(ann)
      obj@GSM_Complex(ann);
      [obj.sim_basis,obj.pc,obj.ev] = obj.OrthonormalizeBasis();
      obj.n_pc = size(obj.pc,2);
      obj.n_b = obj.n_pc;
      obj.n_p = obj.n_q + obj.n_b;
    end
  end
  
end

