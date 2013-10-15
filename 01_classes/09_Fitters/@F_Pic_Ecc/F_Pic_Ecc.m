classdef F_Pic_Ecc < F_Pic & handle
  %F_Pic_Ecc Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    v
    vbold
    num
    invH_x_vbold
    aux1
  end
  
  methods
    function obj = F_Pic_Ecc(f)
      obj = obj@F_Pic(f);
    end
  end
  
end

