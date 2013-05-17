function [duidb] = Compute_duidb(obj)
  %Compute_duidb Summary of this function goes here
  %   Detailed explanation goes here

  duidb = Compute_duidb@GSM(obj);
  duidb = obj.ComputeComplexDerivative(duidb);

end

