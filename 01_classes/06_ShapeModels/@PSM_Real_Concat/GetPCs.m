function [pc] = GetPCs(obj)
  %GetPCs Summary of this function goes here
  %   Detailed explanation goes here
  
  n_r_total = sum(obj.n_r);
  part_pc_matrix = obj.GetPartPCsMatrixForm();

  pc = [obj.pose_pc(:,1:obj.n_l), ...
    obj.mass_pc(:,1:obj.n_f), ...
    part_pc_matrix(:,1:n_r_total)];
  
end

