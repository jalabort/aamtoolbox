classdef (Abstract) iC_Papandreou < iC & handle
  %iC_Papandreou Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sigma_inv_p
    inv_sigma_p0
    sigma_p0
    sigma_pk
  end
  
  % Interface Class
  methods
    dWduvi_uvip = Compute_dWduvi_uvip(obj,A,ann)
  end
  
end
