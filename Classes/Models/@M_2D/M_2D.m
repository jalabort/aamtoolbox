classdef M_2D
  %M_2D Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    n_level
    w
    sm
    tm
  end
  
  methods
    function obj = M_2D(n_level,w,sm,tm)
      obj.n_level = n_level;
      obj.w = w;
      obj.sm = sm;
      obj.tm = tm;
    end
    
    [n_level,w,sm,tm] = AddLevel(obj,w,sm,tm)
    
    Save(obj,opt)
  end
  
  methods (Static)
    [model,loaded] = Load(opt)
  end
  
end

