function [duvidb] = Compute_duvidb(obj)
  %Compute_duidb Summary of this function goes here
  %   Detailed explanation goes here

  duvidb = Compute_duvidb@GSM(obj);
  duvidb = obj.ComputeComplexDerivative(duvidb);

end

