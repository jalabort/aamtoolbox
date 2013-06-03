classdef S_Gaus < S
  %S_Gaus Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    sigma = 1;
    H
  end
  
  methods
    function obj = S_Gaus(sigma)
      if ~isempty(sigma)
        obj.sigma = sigma;
      end
      siz = 2 * obj.sigma + 1;
      obj.H = fspecial('gaussian',[siz siz],obj.sigma);
    end
  end
  
end

