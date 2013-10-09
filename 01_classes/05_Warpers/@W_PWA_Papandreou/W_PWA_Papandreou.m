classdef W_PWA_Papandreou < W_PWA & iC_Papandreou
  %W_PWA_Papandreou Summary of this class goes here
  %   Detailed explanation goes here

  methods
    function obj = W_PWA_Papandreou(w)
      obj = obj@W_PWA(w.rf,w.tri,w.interp);
    end
  end
  
end

