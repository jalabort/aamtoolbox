function [duidl] = Compute_duidl(obj)
  %Compute_duidl Summary of this function goes here
  %   Detailed explanation goes here

  duidl = Compute_duidl@GSM(obj);
  duidl = obj.ComputeComplexDerivative(duidl);

end

