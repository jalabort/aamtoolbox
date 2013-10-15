classdef W_TPS_Papandreou < W_TPS & iC_Papandreou & handle
  %W_TPS_Papandreou Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    dKdxy
  end
  
  methods
    function obj = W_TPS_Papandreou(w)
      obj = obj@W_TPS(w.rf,w.interp);
      for i = 1:obj.rf.n_vert
        mask = obj.r(:,i) == 0;
        obj.dKdxy{i} = 2 * (1 + log(obj.r(:,i).^2)); % r should be here in theory!
        obj.dKdxy{i}(mask) = 0;
      end
    end
  end

end

