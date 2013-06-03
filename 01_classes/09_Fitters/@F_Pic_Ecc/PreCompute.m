function [obj] = PreCompute(obj,i)
  %PRECOMPUTE Summary of this function goes here
  %   Detailed explanation goes here

  obj = PreCompute@F_Pic(obj,i);
  
  obj.v{i} = obj.t{i}' * obj.t{i};
  obj.vbold{i} = obj.J{i}' * obj.t{i};
  obj.invH_x_vbold{i} = obj.invH{i} * obj.vbold{i};
  obj.aux1{i} = obj.vbold{i}' * obj.invH_x_vbold{i};
  obj.num{i} = obj.v{i} - obj.aux1{i};
  
end

