function [duidb_q] = Compute_duidb_q(obj,q)
  %Compute_duidb_q Summary of this function goes here
  %   Detailed explanation goes here

  A = obj.Q2MatForm(q);
  duidb = obj.Compute_duidb();
  
  duidb_q = A(1,1) * duidb + A(2,1) * [-duidb(1+obj.rf.n_vert:end,:);duidb(1:obj.rf.n_vert,:)]; 

end

