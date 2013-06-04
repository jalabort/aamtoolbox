function [obj] = InitializeDense(obj)
  %InitializeDense Summary of this function goes here
  %   Detailed explanation goes here
  
  for level = 1:obj.n_level
    obj = obj.PreComputeDense(level);
  end

end

