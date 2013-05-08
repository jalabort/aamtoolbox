function [obj] = PreCompute(obj,i)
  %PRECOMPUTE Summary of this function goes here
  %   Detailed explanation goes here

  dw_dxy = obj.w{i}.ComputeDWDXY();
  obj.dw_dp{i} = obj.sm{i}.ComputeDWDQPR(dw_dxy);
  %obj.sm{i}.P = obj.sm{i}.ComputeProjector();
 
  %[obj.tm{i}.dt_dx,obj.tm{i}.dt_dy] = obj.tm{i}.ComputeDTDX();
  
end

