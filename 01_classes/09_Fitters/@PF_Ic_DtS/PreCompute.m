function [obj] = PreCompute(obj,i)
  %PreCompute Summary of this function goes here
  %   Detailed explanation goes here
  
  obj = PreCompute@PF_Ic(obj,i);
  
  obj.J{i} = 1 / obj.tm{i}.variance * ...
    (obj.J{i} - ...
    obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c) * ...
    (obj.tm{i}.cropped_pc(:,1:obj.tm{i}.n_c)' * obj.J{i}));
  
  obj.H{i} = obj.J{i}' * obj.J{i};
  
end

