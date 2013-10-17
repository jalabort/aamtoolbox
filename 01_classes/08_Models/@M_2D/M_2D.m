classdef (HandleCompatible) M_2D
  %M_2D Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    n_level = 0
    sm
    w
    tm
    smoother
  end
  
  methods
    function obj = M_2D(sm,w,tm,smoother)
      obj.n_level = length(sm);
      obj.sm = sm;
      obj.w = w;
      obj.tm = tm;
      obj.smoother = smoother;
    end
    
    [n_level,tm,smoother] = AddLevel(obj,tm,smoother)
    
    Save(obj,opt)
  end
  
  methods (Static)
    [model,loaded] = Load(opt)
  end
  
end

