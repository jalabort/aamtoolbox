function [duidb] = Compute_duidb(obj)
  %Compute_duidb Summary of this function goes here
  %   Detailed explanation goes here

  duidl = obj.Compute_duidl();
  duidf = obj.Compute_duidf();
  duidr = obj.Compute_duidr();
  
  duidb = [duidl,duidf,duidr];

end

