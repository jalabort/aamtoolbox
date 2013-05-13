function [sorted_tri] = SortTri(obj)
  %SortTri Summary of this function goes here
  %   Detailed explanation goes here
  
  sorted_tri = num2cell(1:obj.rf.n_vert);
  
  for i = 1:obj.rf.n_vert
    [tri_set, ~] = find(obj.tri == i);
    sorted_tri{i} = tri_set;
  end

end

