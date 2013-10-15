classdef (Abstract) iC_Papandreou < iC
  %iC_Papandreou Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    H
    sigma_b0
  end
  
  % Interface Class
  methods
    dWduvi_uvip = Compute_dWduvi_uvip(obj,A,ann)
  end
  
end
