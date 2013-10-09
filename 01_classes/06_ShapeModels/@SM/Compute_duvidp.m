function [duvidp] = Compute_duvidp(obj)
  %Compute_duvidp Summary of this function goes here
  %   Detailed explanation goes here
  
  duvidp = [obj.Compute_duvidq(),obj.Compute_duvidb()];
  
end

