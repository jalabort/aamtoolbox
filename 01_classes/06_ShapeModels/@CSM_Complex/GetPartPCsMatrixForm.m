function [part_pc_matrix] = GetPartPCsMatrixForm(obj)
  %GetPartPCsMatrixForm Summary of this function goes here
  %   Detailed explanation goes here
  
  n_r_total = sum(obj.n_r);
  part_pc_matrix = zeros(obj.n_vert,n_r_total);
  s = 1;
  for i = 1:obj.n_part
    e = s + obj.n_r(i) - 1;
    part_pc_matrix(obj.i_part_shape{i},s:e) = obj.part_pc{i}(:,1:obj.n_r(i));
    s = e + 1;
  end

end

