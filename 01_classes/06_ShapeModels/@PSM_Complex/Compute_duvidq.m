function [duvidq] = Compute_duvidq(obj)
  %Compute_duvidq Summary of this function goes here
  %   Detailed explanation goes here

  duvidq = Compute_duvidq@PSM(obj);
  duvidq = obj.ComputeComplexDerivative(duvidq);

end

