function [duvidp_uvip,A] = Compute_duvidp_uvip(obj,~)
  %Compute_duvidp_uvip Summary of this function goes here
  %   Detailed explanation goes here
  
  duvidp_uvip = Compute_duvidp(obj); 
  A = [1,0;0,1];
  
end

