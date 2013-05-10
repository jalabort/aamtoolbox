classdef S_Gaus < S
  %S_GAUS Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    H
  end
  
  methods
    function obj = S_Gaus(sigma)
      siz = 2*sigma+1;
      obj.H = fspecial('gaussian',[siz siz],sigma);
    end
  end
  
end

