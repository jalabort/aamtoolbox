function [duvidb_q,A] = Compute_duvidb_q(obj,q)
  %Compute_duvidb_q Summary of this function goes here
  %   Detailed explanation goes here

  A = obj.Q2MatForm(q);
  duvidb = obj.Compute_duvidb();
  
  duvidb_q = A(1,1) * duvidb + A(2,1) * [-duvidb(1+obj.n_vert:end,:);duvidb(1:obj.n_vert,:)]; 

end

