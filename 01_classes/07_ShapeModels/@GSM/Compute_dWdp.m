function [dWdp,dWdq,dWdb] = Compute_dWdp(obj,dWdui)
  %Compute_dWdp Summary of this function goes here
  %   Detailed explanation goes here
  
  [duidq,dvidq] = obj.Shape2UV(obj.Compute_duidq());
  [duidb,dvidb] = obj.Shape2UV(obj.Compute_duidb());
  
  dWdq = [dWdui * duidq;dWdui * dvidq]; 
  dWdb = [dWdui * duidb;dWdui * dvidb];
  
  dWdp = [dWdq,dWdb];
  
end

