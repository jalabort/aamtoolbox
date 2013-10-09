function [duvidb] = Compute_duvidb(obj)
  %Compute_duvidb Summary of this function goes here
  %   Detailed explanation goes here

  duvidf = obj.Compute_duvidf();
  duvidr = obj.Compute_duvidr();
  
  duvidb = [duvidf,duvidr];

end

