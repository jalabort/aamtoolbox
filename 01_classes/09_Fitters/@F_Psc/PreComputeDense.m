function [obj] = PreComputeDense(obj,i)
  %PreComputeDense Summary of this function goes here
  %   Detailed explanation goes here
  
  obj.t{i} = obj.tm{i}.GetMean();
  [dtdx,dtdy] = obj.tm{i}.Compute_dtdxy(obj.t{i});

  obj.dWdp{i} = obj.sm{i}.Compute_duvidp();
  
  obj.Jt{i} = obj.tm{i}.Compute_dtdp(dtdx,dtdy,obj.dWdp{i});
  
end

