function [duidq] = Compute_duidq(obj)
  %Compute_duidq Summary of this function goes here
  %   Detailed explanation goes here

  duidq = Compute_duidq@GSM(obj);
  duidq = obj.ComputeComplexDerivative(duidq);

end

