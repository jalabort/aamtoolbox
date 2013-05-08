function [ref_ann] = ComputeRefAnn(obj)
  %COMPUTEREFANN Summary of this function goes here
  %   Detailed explanation goes here
  
  ann = obj.getAnn();
  ref_ann = mean(ann,3);

end

