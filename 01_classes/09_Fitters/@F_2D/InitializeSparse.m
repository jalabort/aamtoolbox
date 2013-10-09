function [obj] = InitializeSparse(obj)
  %InitializeSparse Summary of this function goes here
  %   Detailed explanation goes here
  
  for level = 1:obj.n_level
    obj = obj.PreComputeSparse(level);
  end

end

