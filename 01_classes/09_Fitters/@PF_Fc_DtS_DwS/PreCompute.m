function [obj] = PreCompute(obj,i)
  %PRECOMPUTE Summary of this function goes here
  %   Detailed explanation goes here
  
  obj = PreCompute@PF_Fc(obj,i);
  
  obj.A{i} = obj.A{i} + ...
    obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c) * ...
    diag(1./obj.tm{i}.ev(1:obj.tm{i}.n_c)) * ...
    obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c)';
end

