classdef GSM_Euler_Real_NWarp < GSM_Euler_Real & Interface_NWarp
  %GSM_Real_NWarp Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = GSM_Euler_Real_NWarp(ann,alpha)
      obj@GSM_Euler_Real(ann,alpha);
      [obj.sim_basis] = obj.OrthonormalizeBasis();
    end
  end
  
end

