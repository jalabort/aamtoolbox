function [obj] = Initialize(obj)
  %INITIALIZE Summary of this function goes here
  %   Detailed explanation goes here
  
  for level = 1:obj.n_level
    obj = obj.PreCompute(level);
  end

end

