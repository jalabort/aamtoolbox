classdef S_Med < S 
  %S_Med Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sigma = 3
    K
  end
  
  methods
    function obj = S_Med(sigma)
      if ~isempty(sigma)
        obj.sigma = sigma;
      end
      obj.K = [obj.sigma,obj.sigma];
    end
  end
  
end

