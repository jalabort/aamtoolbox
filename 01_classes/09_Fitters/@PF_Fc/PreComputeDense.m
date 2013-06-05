function [obj] = PreComputeDense(obj,i)
  %PreComputeDense Summary of this function goes here
  %   Detailed explanation goes here
  
  [dWudp,dWvdp] = obj.sm{i}.Shape2UV(obj.sm{i}.Compute_duvidp());
  obj.dWdp{i} = [dWudp(obj.w{i}.rf.n_vert+1:end,:); ...
    dWvdp(obj.w{i}.rf.n_vert+1:end,:)];
  
end

