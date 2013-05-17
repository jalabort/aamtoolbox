function [ref_ann] = ComputeRefAnn(obj)
  %ComputeRefAnn Summary of this function goes here
  %   Detailed explanation goes here
  
  ann = obj.GetAnn();
  ref_ann = mean(ann,3);

end

