classdef W_TPS_Baker < W_TPS & C_Baker
  %W_TPS_Baker Summary of this class goes here
  %   Detailed explanation goes here
  
  methods
    function obj = W_TPS_Baker(w)
      obj = obj@W_TPS(w.rf,w.interp);
    end
    
    [cann] = Compose_dWodW(obj,mu_ann,qpr_ann,ann)
  end

end

