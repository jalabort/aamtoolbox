function [dWdp,dWdq,dWdb] = Compute_dWdp(obj,dWduvi)
  %Compute_dWdp Summary of this function goes here
  %   Detailed explanation goes here
  
  [duidq,dvidq] = obj.Shape2UV(obj.Compute_duidq());
  [duidb,dvidb] = obj.Shape2UV(obj.Compute_duidb());
  
  dWdq = [dWduvi * duidq;dWduvi * dvidq]; 
  dWdb = [dWduvi * duidb;dWduvi * dvidb];
  
  dWdp = [dWdq,dWdb];
  
end

