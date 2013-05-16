function [i_part_shape] = ComputeShapePartIndexes(obj)
  %ComputeShapePartIndexes Summary of this function goes here
  %   Detailed explanation goes here

  i_part_shape = cell(obj.n_part,1);
  for i = 1:obj.n_part 
    i_part_shape{i} = [obj.i_part_ann{i},obj.n_vert+obj.i_part_ann{i}];
  end

end

