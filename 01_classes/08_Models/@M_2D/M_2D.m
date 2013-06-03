classdef M_2D
  %M_2D Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    n_level = 0
    sm
    w
    tm
  end
  
  methods
    function obj = M_2D(sm,w,tm)
      obj.n_level = length(sm);
      obj.sm = sm;
      obj.w = w;
      obj.tm = tm;
    end
    
    [n_level,w,sm,tm] = AddLevel(obj,w,sm,tm)
    
    Save(obj,opt)
  end
  
  methods (Static)
    [model,loaded] = Load(opt)
  end
  
end

