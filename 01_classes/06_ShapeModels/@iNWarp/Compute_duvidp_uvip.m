function [duvidp_uvip,A] = Compute_duvidp_uvip(obj,p)
  %Compute_duvidp_uvip Summary of this function goes here
  %   Detailed explanation goes here
  
  q = p(1:obj.n_q);
  
  duvidq = obj.Compute_duvidq();
  [duvidb_q,A] = obj.Compute_duvidb_q(q);
  
  duvidp_uvip = [duvidq,duvidb_q];
  
end

