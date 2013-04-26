classdef (Abstract) F_2D < M_2D
  %F_2D Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    face_det
    
    n_it
    
    show_fitting
  end
  
  methods
    function obj = F_2D(m)
      obj = obj@M_2D(m.n_level,m.w,m.sm,m.tm);
    end
    
    obj = Initialize(obj)
    
    fann = Fit(obj,datum)
    [tann,ecc] = Track(obj,img,iann)
  end
  
end

