function [duvidb] = Compute_duvidb(obj)
  %Compute_duidb Summary of this function goes here
  %   Detailed explanation goes here

  duvidl = obj.Compute_duvidl();
  duvidf = obj.Compute_duvidf();
  duvidr = obj.Compute_duvidr();
  
  duvidb = [duvidl,duvidf,duvidr];

end

