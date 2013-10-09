function [duvidl] = Compute_duvidl(obj)
  %Compute_duvidl Summary of this function goes here
  %   Detailed explanation goes here

  duvidl = Compute_duvidl@PSM(obj);
  duvidl = obj.ComputeComplexDerivative(duvidl);

end

