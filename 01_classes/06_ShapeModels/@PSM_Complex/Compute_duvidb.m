function [duvidb] = Compute_duvidb(obj)
  %Compute_duvidb Summary of this function goes here
  %   Detailed explanation goes here

  duvidb = Compute_duvidb@PSM(obj);
  duvidb = obj.ComputeComplexDerivative(duvidb);

end

