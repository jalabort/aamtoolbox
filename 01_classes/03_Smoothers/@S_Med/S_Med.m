classdef S_Med < S 
  %S_Med Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    K
  end
  
  methods
    function obj = S_Med(sigma)
      obj.K = [sigma, sigma];
    end
  end
  
end
